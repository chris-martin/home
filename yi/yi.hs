import Yi

import Yi.Config.Default.Cua            (configureCua)
import Yi.Config.Default.HaskellMode    (configureHaskellMode)
import Yi.Config.Default.JavaScriptMode (configureJavaScriptMode)
import Yi.Config.Default.MiscModes      (configureMiscModes)
import Yi.Config.Default.Vty            (configureVty)
import Yi.Config.Simple.Types           (ConfigM, runConfigM)

import Control.Monad.State.Lazy (execStateT)
import Data.List                (intersperse)
import Lens.Micro.Platform      ((.=))
import System.Environment       (getArgs)

main :: IO ()
main = do
  files <- getArgs

  let
    openFileActions = intersperse (EditorA newTabE)
                        (map (YiA . openNewFile) files)

    config = do
      configureHaskellMode
      configureJavaScriptMode
      configureMiscModes
      configureCua
      configureVty
      startActionsA .= openFileActions

  cfg <- execStateT (runConfigM config) defaultConfig

  startEditor cfg Nothing
