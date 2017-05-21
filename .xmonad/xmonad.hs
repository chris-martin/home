import XMonad
import XMonad.Hooks.EwmhDesktops

main = xmonad $ ewmh def{ handleEventHook =
           handleEventHook def <+> fullscreenEventHook }
