module Main (main) where

import Protolude hiding (getContents, error)
import Prelude (id)

import Data.Aeson (FromJSON(..))
import Data.ByteString (getContents)
import Data.Text (Text)
import GHC.Generics (Generic)
import Nix.Expr (NExpr, Binding(..))
import Prelude (error)
import System.IO (hFlush)
import System.Process.ByteString (readProcessWithExitCode)

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as AesonT
import qualified Data.Text as Text
import qualified Data.Text.Encoding as TextEncoding
import qualified Nix.Expr
import qualified Nix.Pretty
import qualified Text.PrettyPrint.ANSI.Leijen as Pretty

data Manifest_json = Manifest_json
    { mf_dependencies :: [Dependency_json]
    } deriving (Generic)

instance FromJSON (Manifest_json) where
    parseJSON = Aeson.genericParseJSON AesonT.defaultOptions
        { AesonT.fieldLabelModifier = drop 3 } -- remove the "mf_" prefix

data Dependency_json = Dependency_json
    { dp_importpath :: Text
    , dp_repository :: Text
    , dp_revision :: Text
    , dp_path :: Maybe Text
    } deriving (Generic)

instance FromJSON (Dependency_json) where
    parseJSON = Aeson.genericParseJSON AesonT.defaultOptions
        { AesonT.fieldLabelModifier = drop 3 } -- remove the "dp_" prefix

data GoDep_nix = GoDep_nix
    { gd_goPackagePath :: Text
    , gd_url :: Text
    , gd_rev :: Text
    , gd_path :: Maybe Text
    , gd_sha256 :: Text
    }

goDepExpr :: GoDep_nix -> NExpr
goDepExpr dep = Nix.Expr.mkNonRecSet $
    [ NamedVar ["goPackagePath"] $ Nix.Expr.mkStr $ gd_goPackagePath dep
    , NamedVar ["path"] $ Nix.Expr.mkStr $ maybe "" id $ gd_path dep
    , NamedVar ["fetch"] $ Nix.Expr.mkNonRecSet
       [ NamedVar ["type"] $ Nix.Expr.mkStr "git"
       , NamedVar ["url"] $ Nix.Expr.mkStr $ gd_url dep
       , NamedVar ["rev"] $ Nix.Expr.mkStr $ gd_rev dep
       , NamedVar ["sha256"] $ Nix.Expr.mkStr $ gd_sha256 dep
       ]
    ]

data NixPrefetch_json = NixPrefetch_json { np_sha256 :: Text }
    deriving (Generic)

instance FromJSON (NixPrefetch_json) where
    parseJSON = Aeson.genericParseJSON AesonT.defaultOptions
        { AesonT.fieldLabelModifier = drop 3 } -- remove the "np_" prefix

getSha256 :: Dependency_json -> IO Text
getSha256 gbDep = do
    (exitcode, result_out, result_err) <-
        readProcessWithExitCode
            "nix-prefetch-git"
            [ Text.unpack $ dp_repository gbDep
            , Text.unpack $ dp_revision gbDep
            ] mempty
    case exitcode of
        ExitSuccess -> either error (pure . np_sha256) $
            Aeson.eitherDecodeStrict' result_out
        _ -> do
            let m = "nix-prefetch-git failed"
            error $ either ((m <>) . show) ((m <>) . Text.unpack) $
                TextEncoding.decodeUtf8' result_err

outputNixDep :: GoDep_nix -> IO ()
outputNixDep dep = do
    Pretty.putDoc $ Pretty.indent 2 $ Nix.Pretty.prettyNix $ goDepExpr dep
    putStrLn ("" :: Text)
    hFlush stdout

handleDep :: Dependency_json -> IO ()
handleDep gbDep = do
    sha256 <- getSha256 gbDep
    let nixDep = GoDep_nix
            { gd_goPackagePath = dp_importpath gbDep
            , gd_url = dp_repository gbDep
            , gd_rev = dp_revision gbDep
            , gd_path = dp_path gbDep
            , gd_sha256 = sha256
            }
    outputNixDep nixDep

main :: IO ()
main = do
    bs <- getContents
    mf <- either error pure $ Aeson.eitherDecodeStrict' bs
    let deps = mf_dependencies mf
    putStrLn ("[" :: Text)
    mapM_ handleDep deps
    putStrLn ("]" :: Text)
