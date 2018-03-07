import Yi                               (Action (..), BufferM, Region, YiM)
import Yi.Config.Default.Cua            (configureCua)
import Yi.Config.Default.HaskellMode    (configureHaskellMode)
import Yi.Config.Default.JavaScriptMode (configureJavaScriptMode)
import Yi.Config.Default.MiscModes      (configureMiscModes)
import Yi.Config.Default.Vty            (configureVty)
import Yi.Config.Simple.Types           (ConfigM, runConfigM)
import Yi.Mode.Common                   (TokenBasedMode)
import Yi.String                        (fillText)

import Yi.Config.Simple
    (TextUnit (..), addMode, atEof, atSol, ctrlCh, defaultConfig,
    deleteRegionB, globalBindKeys, inclusiveRegionB, lineDown, metaCh,
    modePrettify, modePrettifyA, modifyRegionB, newTabE, openNewFile,
    regionOfB, startActionsA, startEditor, unitParagraph, withCurrentBuffer,
    withSyntax, (?>>!))

import qualified Yi.Lexer.GitCommit as GitCommit
import qualified Yi.Modes
import qualified Yi.Rope            as R

import Control.Lens             ((.~))
import Control.Monad            (unless)
import Control.Monad.State.Lazy (execStateT)
import Data.Function            ((&))
import Data.List                (intersperse)
import Lens.Micro.Platform      ((.=))
import System.Environment       (getArgs)

main :: IO ()
main = do
  args <- getArgs

  let
    files = case args of
              -- If no args are given, open the current directory
              [] -> ["."]
              xs -> xs

    openFileActions = intersperse (EditorA newTabE)
                        (map (YiA . openNewFile) files)

    config = do
      configureHaskellMode
      configureJavaScriptMode
      addMode Yi.Modes.cMode
      addMode Yi.Modes.objectiveCMode
      addMode Yi.Modes.cppMode
      addMode Yi.Modes.cabalMode
      addMode Yi.Modes.clojureMode
      addMode Yi.Modes.srmcMode
      addMode gitCommitMode
      addMode Yi.Modes.svnCommitMode
      addMode Yi.Modes.ocamlMode
      addMode Yi.Modes.perlMode
      addMode Yi.Modes.rubyMode
      addMode Yi.Modes.pythonMode
      addMode Yi.Modes.jsonMode
      addMode Yi.Modes.gnuMakeMode
      addMode Yi.Modes.ottMode
      addMode Yi.Modes.whitespaceMode
      configureCua
      configureVty
      globalBindKeys (ctrlCh 'y' ?>>! delLine)
      globalBindKeys (metaCh 'q' ?>>! withSyntax modePrettify)
      startActionsA .= openFileActions

  cfg <- execStateT (runConfigM config) defaultConfig

  startEditor cfg Nothing

-- | Deletes the current line, moving the cursor as little as possible. If
-- the cursor is on a blank line at the end of the file, this has no effect.

delLine :: YiM ()
delLine = withCurrentBuffer delLineB

delLineB :: BufferM ()
delLineB = do
  e <- (&&) <$> atEof <*> atSol
  unless e $ do
    r <- inclusiveRegionB =<< regionOfB Line
    lineDown
    deleteRegionB r

gitCommitMode :: TokenBasedMode GitCommit.Token
gitCommitMode = Yi.Modes.gitCommitMode
  & modePrettifyA .~ const (fillParagraph 72)

fillParagraph :: Int -> BufferM ()
fillParagraph cols =
  fillRegion cols =<< regionOfB unitParagraph

-- | Fills the text in the region so it fits some number of columns.

fillRegion :: Int -> Region -> BufferM ()
fillRegion cols = modifyRegionB (R.unlines . fillText cols)
