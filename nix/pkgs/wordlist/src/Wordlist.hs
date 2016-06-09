{-# LANGUAGE OverloadedStrings #-}

module Wordlist (main) where

import           Prelude                     (IO, Int, Maybe, show, ($), (++),
                                              (-), (.), (<$>), (<*>))

import           Control.Applicative         (optional)
import           Control.Monad               (replicateM, return)

import           Data.Maybe                  (fromMaybe)
import           Data.Monoid                 ((<>))
import           Data.String                 (fromString)

import           Data.Sequence               (Seq)
import qualified Data.Sequence               as Seq

import           Data.Text                   (Text)
import qualified Data.Text                   as Text
import qualified Data.Text.IO                as TextIO

import qualified Options.Applicative.Builder as Opt
import           Options.Applicative.Extra   (execParser, helper)
import           Options.Applicative.Types   (Parser)

import           System.Environment          (getEnv)
import           System.Random               (randomRIO)

data Args = Args
  { argN :: Maybe Int
  , argD :: Maybe Text
  }

defaultN :: Int
defaultN = 4

defaultD :: Text
defaultD = " "

readText :: Opt.ReadM Text
readText = fromString <$> Opt.str

readInt :: Opt.ReadM Int
readInt = Opt.auto

parserN :: Parser (Maybe Int)
parserN = optional $ Opt.option readInt
   ( Opt.long "number"
  <> Opt.short 'n'
  <> Opt.help ("Number of words (default: " ++ show defaultN ++ ")")
   )

parserD :: Parser (Maybe Text)
parserD = optional $ Opt.option readText
   ( Opt.long "delimiter"
  <> Opt.short 'd'
  <> Opt.help "Delimiter between words (default: space)"
   )

parser :: Parser Args
parser = Args <$> parserN <*> parserD

parserInfo :: Opt.InfoMod a
parserInfo = Opt.header
  "Generates random English words. Useful for password generation."

randomFromSeq :: Seq a -> IO a
randomFromSeq xs = do
  i <- randomRIO (0, Seq.length xs - 1)
  return $ Seq.index xs i

getN :: Args -> Int
getN = fromMaybe defaultN . argN

getD :: Args -> Text
getD = fromMaybe defaultD . argD

main :: IO ()
main = do
  args <- execParser $ Opt.info (helper <*> parser) parserInfo
  path <- getEnv "WORD_LIST_PATH"
  allText <- TextIO.readFile path
  let allWords = Seq.fromList $ Text.lines allText
  selectedWords <- replicateM (getN args) (randomFromSeq allWords)
  TextIO.putStrLn $ Text.intercalate (getD args) selectedWords
