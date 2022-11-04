-- spell-checker:words xmonad
import XMonad

import System.Exit
import XMonad.Util.EZConfig

terminal = "kitty"      -- Kitty, my beloved <3
launcher = "pkill rofi; rofi -show combi"
networkManager = "wpa_cli select_network $(wpa_cli list_networks | tail -n +3 | rofi -dmenu -window-title 'Select Network' | awk '{print $1;}')"
modifierKey = mod4Mask  -- Use Super as our mod key

statusBar = "pkill polybar; polybar"

shift = shiftMask

startupHook = do
  spawn statusBar

main :: IO ()
main = xmonad $ ewmh def
  { modMask = modifierKey  -- Use Super as our mod key
  , XMonad.terminal = Main.terminal
  , startupHook = startupHook
  } `additionalKeys`
  [ ((modifierKey, xK_d), spawn launcher)
  , ((modifierKey, xK_n), spawn networkManager)
  , ((modifierKey .|. shift, xK_q), kill)
  , ((modifierKey, xK_q), spawn "xmonad --restart")
  , ((modifierKey .|. shift, xK_c), io (exitWith ExitSuccess))
  ]
