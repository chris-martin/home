{-# LANGUAGE OverloadedStrings #-}

module Wordlist.Args (getArgs, getN, getD) where

import Prelude (IO, Int, Maybe, show, ($), (++), (.), (<$>), (<*>))

import Control.Applicative (optional)

import Data.Maybe  (fromMaybe)
import Data.Monoid ((<>))
import Data.String (fromString)
import Data.Text   (Text)

import qualified Options.Applicative.Builder as Opt
import           Options.Applicative.Extra   (execParser, helper)
import           Options.Applicative.Types   (Parser)


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
parserN = optional $ Opt.option readInt $
    Opt.long "number" <> Opt.short 'n' <> Opt.help help
    where
    help = "Number of words (default: " ++ show defaultN ++ ")"

parserD :: Parser (Maybe Text)
parserD = optional $ Opt.option readText $
    Opt.long "delimiter" <> Opt.short 'd' <> Opt.help help
    where
    help = "Delimiter between words (default: space)"

parser :: Parser Args
parser = Args <$> parserN <*> parserD

parserInfo :: Opt.InfoMod a
parserInfo = Opt.header
    "Generates random English words. Useful for password generation."

getArgs :: IO Args
getArgs = execParser $ Opt.info (helper <*> parser) parserInfo

getN :: Args -> Int
getN = fromMaybe defaultN . argN

getD :: Args -> Text
getD = fromMaybe defaultD . argD
