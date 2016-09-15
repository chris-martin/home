module Main (main) where

import qualified Wordlist.Args as Args

import Prelude (IO, ($), (-), (<$>), (>>), take)

import Control.Monad (return)
import Control.Monad.Random (Rand, RandomGen, evalRandIO, getRandomRs)

import           Data.Sequence (Seq)
import qualified Data.Sequence as Seq

import qualified Data.Text    as Text
import qualified Data.Text.IO as TextIO

import System.Environment (getEnv)
import System.IO          (hFlush, hPutStr, stderr, stdout)

main :: IO ()
main = do

    -- Read the command-line args
    args <- Args.getArgs
    let n = Args.getN args
    let d = Args.getD args

    -- Read the word data
    path <- getEnv "WORD_LIST_PATH"
    allText <- TextIO.readFile path
    let allWords = Seq.fromList $ Text.lines allText

    -- Choose n of the words
    selectedWords <- evalRandIO $ take n <$> randomRsSeq allWords

    -- Concatenate the words
    let result = Text.intercalate d selectedWords
    
    -- Print the result
    TextIO.putStr result >> hFlush stdout >> hPutStr stderr "\n"

randomRsSeq :: (RandomGen g) => Seq a -> Rand g [a]
randomRsSeq xs = do
    indices <- getRandomRs (0, Seq.length xs - 1)
    return $ Seq.index xs <$> indices
