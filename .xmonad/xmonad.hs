import XMonad
import XMonad.Hooks.EwmhDesktops

main :: IO ()
main =
  xmonad xconfig

xconfig :: XConfig (Choose Tall (Choose (Mirror Tall) Full))
xconfig =
  ewmh
  def { handleEventHook = handleEventHook def <+> fullscreenEventHook
      }
