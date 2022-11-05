-- spell-checker:words xmonad
import           XMonad

import           System.Exit
import           XMonad.Util.EZConfig

import           XMonad.Config.Desktop
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks

import qualified DBus.Client                as D
import           XMonad.Hooks.DynamicLog
import           XMonadLog

import           XMonad.Hooks.ManageHelpers (isInProperty, doLower)
import           XMonad.Layout.Gaps
import           XMonad.Layout.Spacing
import Foreign.C
import Blaze.ByteString.Builder (toByteString)
import XMonad.Layout.Drawer (propertyToQuery)

terminal = "kitty"      -- Kitty, my beloved <3
launcher = "pkill rofi; rofi -show combi"
networkManager = "wpa_cli select_network $(wpa_cli list_networks | tail -n +3 | rofi -dmenu -window-title 'Select Network' | awk '{print $1;}')"
modifierKey = mod4Mask  -- Use Super as our mod key

statusBar = "pkill polybar; polybar"
compositor = "pkill picom; picom"
background = "pkill show; show ~/.xmonad/wallpaper.glsl"

shift = shiftMask

startupHook = do
  spawn Main.statusBar
  spawn Main.compositor
  spawn background


main :: IO ()
main = XMonadLog.xmonadLog >>= main'

main' :: D.Client -> IO ()
main' dbus = xmonad $ ewmh . ewmhFullscreen $ docks $ def
  { modMask = modifierKey  -- Use Super as our mod key
  , borderWidth = 0
  , XMonad.terminal = Main.terminal
  , XMonad.startupHook = Main.startupHook
  , XMonad.logHook = dynamicLogWithPP (polybarHook dbus)
  , XMonad.layoutHook = avoidStruts $
                        smartSpacing 5 $
                        gaps [(U, 5), (D, 5), (L, 5), (R, 5)] $
                        layoutHook def
  , XMonad.manageHook = composeAll
                        [ className =? "Show" --> doIgnore <+> doLower <+> doLower
                        -- You can't check if "Show" is a desktop window,
                        -- I believe it's because show doesn't instantly set
                        -- desktop. Do not try. It is not worth it.
                        ] <+> manageHook def
  } `additionalKeys`
  [ ((modifierKey, xK_d), spawn launcher)
  , ((modifierKey, xK_n), spawn networkManager)
  , ((modifierKey .|. shift, xK_q), kill)
  , ((modifierKey, xK_q), spawn "xmonad --restart")
  , ((modifierKey .|. shift, xK_c), io exitSuccess)
  ]
