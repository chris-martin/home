module Choose.Args (Args(..), getArgs, getN) where

import Prelude (IO, Int, Maybe (..), Ord, show, ($), (+), (++), (.), (<$>),
                (<*>))

import Control.Applicative (optional)

import Data.Maybe  (fromMaybe)
import Data.Monoid ((<>))

import qualified Options.Applicative.Builder as Opt
import           Options.Applicative.Extra   (execParser, helper)
import           Options.Applicative.Types   (Parser)


data Args = Args { argN :: Maybe Int }

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

getArgs :: IO Args
getArgs = execParser $ Opt.info (helper <*> parser) parserInfo
