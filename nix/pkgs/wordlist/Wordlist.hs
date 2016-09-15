module Main (main) where

import qualified Wordlist.Args as Args

import Prelude (IO, ($), (-), (<$>), (>>), take)

import Control.Monad (return)
import Control.Monad.Random (Rand, RandomGen, evalRandIO, getRandomRs)

import           Data.Sequence (Seq)
import qualified Data.Sequence as Seq

import           Data.Text    (Text)
import qualified Data.Text    as Text
import qualified Data.Text.IO as TextIO

import System.Environment (getEnv)
import System.IO          (hFlush, hPutStr, stderr, stdout)

main :: IO ()
main = do
    args <- Args.getArgs
    path <- getEnv "WORD_LIST_PATH"
    allText <- TextIO.readFile path
    let allWords = Seq.fromList $ Text.lines allText
    selectedWords <- evalRandIO $ take (Args.getN args) <$> randomRsSeq allWords
    printResult $ Text.intercalate (Args.getD args) selectedWords

printResult :: Text -> IO ()
printResult x = TextIO.putStr x >> hFlush stdout >> hPutStr stderr "\n"

randomRsSeq :: (RandomGen g) => Seq a -> Rand g [a]
randomRsSeq xs = do
    indices <- getRandomRs (0, Seq.length xs - 1)
    return $ Seq.index xs <$> indices
