-- | Reads lines from stdin and outputs N of them, selected uniformly at
-- random.
--
-- * Algorithm outline
--
-- We store items on a binary tree, moving them down the left or right branch
-- according to a coin flip. At the end, the rightmost N items on the tree are
-- selected. Each time we insert into a tree having N items, we prune its
-- leftmost item.
--
-- It may be helpful to think of this as lazily assigning each item a d-bit
-- score, where d is the maximum depth of the tree. Moving an item to the
-- left or right corresponds to appending a 0 or 1 to its score. Note that
-- the laziness is necessary, because d is not known a priori.
--
-- The process of moving items futher down the tree is herein referred to as
-- "disambiguation", because its purpose is to resolve ties in the score.

module Choose (main) where

import Prelude (Bool (..), Either (..), Foldable (..), IO, Int, Maybe (..),
                mapM_, not, pure, show, snd, ($), (+), (++), (-), (.), (<$>),
                (<*>), (<=), (=<<), (==), (>))

import Control.Applicative    (optional)
import Control.Exception.Base (try)
import Control.Monad          (return, when)

import qualified Data.Foldable as Foldable
import           Data.List     (sort)
import           Data.Maybe    (fromMaybe)
import           Data.Monoid   ((<>))
import           Data.Text     (Text)
import qualified Data.Text.IO  as TextIO

import qualified Options.Applicative.Builder as Opt
import           Options.Applicative.Extra   (execParser, helper)
import           Options.Applicative.Types   (Parser)

import System.IO       (stdin)
import System.IO.Error (ioError, isEOFError)
import System.Random   (randomIO)


-------------------------------------------------------------------------------
--  Command-line args
-------------------------------------------------------------------------------

data Args = Args
    { argN :: Maybe Int
    }

defaultN :: Int
defaultN = 1

readInt :: Opt.ReadM Int
readInt = Opt.auto

parserN :: Parser (Maybe Int)
parserN = optional $ Opt.argument readInt $ Opt.metavar "N" <> Opt.help help
    where help = "Number of items to choose (default: " ++ show defaultN ++ ")"

getN :: Args -> Int
getN = fromMaybe defaultN . argN

parser :: Parser Args
parser = Args <$> parserN

parserInfo :: Opt.InfoMod a
parserInfo = Opt.header "Selects lines from stdin uniformly at random."


-------------------------------------------------------------------------------
--  Main
-------------------------------------------------------------------------------

main :: IO ()
main = do
    args <- execParser $ Opt.info (helper <*> parser) parserInfo
    let n = getN args
    when (n > 0) $ do
        selections <- getSelections n
        mapM_ TextIO.putStrLn selections

getSelections :: Int -> IO [Text]
getSelections limit = f 0 Nil
    where
    -- We store each line of text along with its index (i) so that when we're
    -- done, we can sort by the index, thus outputting the selected items in
    -- the same order in which they were read.
    f :: Int -> Tree (Int, Text) -> IO [Text]
    f i tree = do
        lineMaybe <- readLine
        case lineMaybe of
            -- We read a line; insert it into the tree and recurse.
            Just line -> do
                tree' <- applyLimit limit . insert (i, line) $ tree
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


-------------------------------------------------------------------------------
--  Core algorithm
-------------------------------------------------------------------------------

data Tree a = Nil | Tree
    { treeSize   :: Int    -- ^ Total number of items at this node and below
    , treeValues :: [a]    -- ^ Items at this node
    , treeLeft   :: Tree a -- ^ Left subtree (less likely for inclusion)
    , treeRight  :: Tree a -- ^ Right subtree (more likely for inclusion)
    }

instance Foldable Tree where

    foldr _ z Nil = z
    foldr f z (Tree size (x:xs) left right) =
        foldr f (f x z) (Tree (size - 1) xs left right)
    foldr f z (Tree size [] left right) =
        (\z -> foldr f z left) . (\z -> foldr f z right) $ z

    length Nil = 0
    length t@Tree{} = treeSize t

    null Nil = True
    null t@Tree{} = treeSize t == 0

-- | Trivial insertion into the root of a tree, increasing its size by 1
-- and leaving its children unmodified.
insert :: a -> Tree a -> Tree a
insert x Nil = Tree 1 [x] Nil Nil
insert x (Tree size xs left right) = Tree (size + 1) (x:xs) left right

-- | Remove items from the tree until its size is at most @limit@.
-- This may involve disambiguation if eviction takes place.
applyLimit :: Int -- ^ @limit@
           -> Tree a
           -> IO (Tree a)
applyLimit limit _ | limit <= 0 = pure Nil
applyLimit limit tree =
    -- If the tree is small enough: We don't need to do anything.
    if length tree <= limit then pure tree
    -- If the tree is oversized: Remove an item from it, and recurse.
    else applyLimit limit =<< evict tree

-- | Remove one item from the tree (or leave the tree unmodified if it is
-- already empty). This may involve disambiguation if there is not already
-- a clear leftmost item.
evict :: Tree a -> IO (Tree a)
evict tree | length tree <= 1 = pure Nil
evict tree = do
    (Tree _ _ left right) <- disambiguate tree
    -- Evict from one of the subtrees, preferring to evict from the left.
    (left', right') <- if not . null $ left
                       then (\x -> (x, right)) <$> evict left
                       else (\x -> (left, x)) <$> evict right
    return $ Tree (length left' + length right') [] left' right'

-- | Perform disambiguation at the root level only, pushing items from
-- the root down into subtrees as necessary.
disambiguate :: Tree a -> IO (Tree a)
-- No items at the root: No disambiguation is possible at the root level.
disambiguate tree@(Tree _ [] _ _) = pure tree
-- A single item with no children: No disambiguation is required on this tree.
disambiguate tree@(Tree _ [_] Nil Nil) = pure tree
-- There is at least one item at the root that needs to be pushed down, to
-- disambiguate it (either from items in subtrees, or from other items at
-- the root).
disambiguate (Tree size (x:xs) left right) = do
    b <- randomIO
    let (left', right') = if b
                          then (insert x left, right)
                          else (left, insert x right)
    disambiguate $ Tree size xs left' right'
