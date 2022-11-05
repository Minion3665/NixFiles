-- spell-checker:words xmonad
import XMonad

import System.Exit
import XMonad.Util.EZConfig

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop

import XMonadLog
import XMonad.Hooks.DynamicLog
import qualified DBus.Client as D

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

terminal = "kitty"      -- Kitty, my beloved <3
launcher = "pkill rofi; rofi -show combi"
networkManager = "wpa_cli select_network $(wpa_cli list_networks | tail -n +3 | rofi -dmenu -window-title 'Select Network' | awk '{print $1;}')"
modifierKey = mod4Mask  -- Use Super as our mod key

statusBar = "pkill polybar; polybar"
compositor = "pkill picom; picom"
background = "feh --no-fehbg --bg-fill .xmonad/background.png"

shift = shiftMask

startupHook = do
  spawn Main.statusBar
  spawn Main.compositor
  spawn background
  

main :: IO ()
main = XMonadLog.xmonadLog >>= main'

main' :: D.Client -> IO ()
main' dbus = xmonad $ docks $ ewmh . ewmhFullscreen $ def
  { modMask = modifierKey  -- Use Super as our mod key
  , borderWidth = 0
  , XMonad.terminal = Main.terminal
  , XMonad.startupHook = Main.startupHook
  , XMonad.logHook = dynamicLogWithPP (polybarHook dbus)
  , XMonad.layoutHook = avoidStruts $
                        smartSpacing 5 $
                        gaps [(U, 5), (D, 5), (L, 5), (R, 5)] $
                        layoutHook def
  } `additionalKeys`
  [ ((modifierKey, xK_d), spawn launcher)
  , ((modifierKey, xK_n), spawn networkManager)
  , ((modifierKey .|. shift, xK_q), kill)
  , ((modifierKey, xK_q), spawn "xmonad --restart")
  , ((modifierKey .|. shift, xK_c), io (exitWith ExitSuccess))
  ]
