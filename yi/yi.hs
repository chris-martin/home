import Yi
import Yi.Buffer.HighLevel
import Yi.Config.Default.Cua            (configureCua)
import Yi.Config.Default.HaskellMode    (configureHaskellMode)
import Yi.Config.Default.JavaScriptMode (configureJavaScriptMode)
import Yi.Config.Default.MiscModes      (configureMiscModes)
import Yi.Config.Default.Vty            (configureVty)
import Yi.Config.Simple
import Yi.Config.Simple.Types           (ConfigM, runConfigM)

import Control.Monad            (unless)
import Control.Monad.State.Lazy (execStateT)
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
      configureMiscModes
      configureCua
      configureVty
      globalBindKeys (ctrlCh 'y' ?>>! delLine)
      startActionsA .= openFileActions

  cfg <- execStateT (runConfigM config) defaultConfig

  startEditor cfg Nothing

-- | Deletes the current line, moving the cursor as little as possible. If
-- the cursor is on a blank line at the end of the file, this has no effect.

delLine :: YiM ()
delLine = withCurrentBuffer delLineB

delLineB :: BufferM ()
delLineB = do
  e <- atEndB
  unless e $ do
    r <- inclusiveRegionB =<< regionOfB Line
    lineDown
    deleteRegionB r

atEndB :: BufferM Bool
atEndB = (&&) <$> atEof <*> atSol
