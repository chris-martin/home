{-# LANGUAGE ScopedTypeVariables #-}

-- | Reads lines from stdin and outputs N of them, selected uniformly at
-- random.
--
-- The algorithm is described in "Choose.Tree".

module Main (main) where

import qualified Choose.Args as Args
import           Choose.Tree (Tree)
import qualified Choose.Tree as Tree

import Prelude (Either (..), IO, Int, Maybe (..), Ord, mapM_, snd, ($), (+),
                (.), (<$>), (>))

import Control.Exception.Base (try)
import Control.Monad          (return, when)
import Control.Monad.Random   (evalRandIO)

import qualified Data.Foldable as Foldable
import           Data.List     (sort)
import           Data.Text     (Text)
import qualified Data.Text.IO  as TextIO

import System.IO       (stdin)
import System.IO.Error (ioError, isEOFError)


main :: IO ()
main = do
    args <- Args.getArgs
    let n = Args.getN args
    when (n > 0) $ do
        selections <- getSelectionsIO readLine n
        mapM_ TextIO.putStrLn selections

getSelectionsIO :: forall a. (Ord a) =>
  IO (Maybe a) -- ^ Producer of items to choose from
               -- (produce Nothing when there are no more items)
  -> Int       -- ^ Number of items to choose
  -> IO [a]
getSelectionsIO getItem limit = f 0 Tree.Nil
    where
    -- We store each line of text along with its index (i) so that when we're
    -- done, we can sort by the index, thus outputting the selected items in
    -- the same order in which they were read.
    f :: Int -> Tree (Int, a) -> IO [a]
    f i tree = do
        lineMaybe <- getItem
        case lineMaybe of
            -- We read a line; insert it into the tree and recurse.
            Just line -> do
                tree' <- evalRandIO $ Tree.applyLimit limit . Tree.insert (i, line) $ tree
                f (i + 1) tree'
            -- We've reached the end of the input. Convert the tree to a list,
            -- sort it, and strip out the indices to return just the text.
            Nothing -> return $ snd <$> sort (Foldable.toList tree)

-- | Produces @Just@ a line of text, or @Nothing@ if the stream has ended.
readLine :: IO (Maybe Text)
readLine = do
    lineEither <- try $ TextIO.hGetLine stdin
    case lineEither of
        Left e -> if isEOFError e then return Nothing else ioError e
        Right line -> return $ Just line
