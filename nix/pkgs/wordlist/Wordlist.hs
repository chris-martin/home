module Main (main) where

import qualified Wordlist.Args as Args

import Prelude (IO, ($), (-))

import Control.Monad (replicateM, return)

import           Data.Sequence (Seq)
import qualified Data.Sequence as Seq

import qualified Data.Text    as Text
import qualified Data.Text.IO as TextIO

import System.Environment (getEnv)
import System.IO          (hFlush, hPutStr, stderr, stdout)
import System.Random      (randomRIO)

main :: IO ()
main = do
    args <- Args.getArgs
    path <- getEnv "WORD_LIST_PATH"
    allText <- TextIO.readFile path
    let allWords = Seq.fromList $ Text.lines allText
    selectedWords <- replicateM (Args.getN args) (randomFromSeq allWords)
    TextIO.putStr $ Text.intercalate (Args.getD args) selectedWords
    hFlush stdout
    hPutStr stderr "\n"

randomFromSeq :: Seq a -> IO a
randomFromSeq xs = do
    i <- randomRIO (0, Seq.length xs - 1)
    return $ Seq.index xs i
