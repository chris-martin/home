import XMonad
import XMonad.Actions.WindowBringer
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import Data.Semigroup ((<>))

main = xmonad $
  desktopConfig
    { terminal = "gnome-terminal"
    , modMask = mod4Mask
    , layoutHook = smartSpacing 20 $ Tall 1 (3/100) (1/2)
    }
  `additionalKeys`
    [ ((0, 0x1008FF11), spawn "amixer -q sset Master 2%-")
    , ((0, 0x1008FF13), spawn "amixer -q sset Master 2%+")
    , ((0, 0x1008FF12), spawn "amixer set Master toggle")
    , ((mod4Mask, xK_g), gotoMenu)
    , ((mod4Mask, xK_b), bringMenu)
    ]
