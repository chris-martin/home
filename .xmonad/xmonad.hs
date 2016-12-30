import XMonad
import XMonad.Hooks.EwmhDesktops

main = xmonad $ ewmh defaultConfig{ handleEventHook =
           handleEventHook defaultConfig <+> fullscreenEventHook }
