-- spell-checker:words xmonad
import XMonad

import XMonad.Util.EZConfig

main :: IO ()
main = xmonad $ def
  { modMask = mod4Mask  -- Use Super as our mod key
  , terminal = "kitty"  -- Kitty, my beloved <3
  }
