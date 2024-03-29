-- spell-checker:words xmonad
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Move brackets to avoid $" #-}
import           XMonad

import           System.Exit
import           XMonad.Util.EZConfig

import           XMonad.Config.Desktop
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks

import qualified DBus.Client                  as D
import           XMonad.Hooks.DynamicLog
import           XMonadLog

import           Blaze.ByteString.Builder     (toByteString)
import           Data.Containers
import           Data.List                    ((\\))
import qualified Data.Map                     as M
import           Foreign.C
import           Graphics.X11.ExtraTypes      (xF86XK_AudioLowerVolume,
                                               xF86XK_AudioMute,
                                               xF86XK_AudioRaiseVolume,
                                               xF86XK_MonBrightnessDown,
                                               xF86XK_MonBrightnessUp,
                                               xF86XK_Xfer)
import qualified XMonad                       as W
import           XMonad.Hooks.DynamicProperty (dynamicPropertyChange)
import           XMonad.Hooks.ManageHelpers   (doFullFloat, doLower,
                                               doRectFloat, isInProperty)
import           XMonad.Hooks.Place           (fixed, placeHook, underMouse, withGaps)
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout                (Tall)
import           XMonad.Layout.Drawer         (propertyToQuery)
import           XMonad.Layout.Gaps
import           XMonad.Layout.Grid
import           XMonad.Layout.MultiToggle    (mkToggle)
import           XMonad.Layout.NoBorders      (Ambiguity (Combine, OnlyScreenFloat),
                                               SetsAmbiguous, With (Union),
                                               hasBorder, hiddens, lessBorders,
                                               smartBorders)
import           XMonad.Layout.ResizableTile  (MirrorResize (MirrorExpand, MirrorShrink),
                                               ResizableTall (ResizableTall))
import           XMonad.Layout.Spacing
import qualified XMonad.StackSet              as W
import           XMonad.StackSet              (allWindows)
import           XMonad.Util.Hacks
import           XMonad.Util.PureX            (curScreen, curScreenId)
import           XMonad.Util.Run              (safeSpawn, safeSpawnProg)

volumeChangeCmd = "${{./vol_change.py}}"

terminal = "/usr/bin/env SHLVL=0 kitty"      -- Kitty, my beloved <3
launcher = "pkill rofi; rofi -show combi"
networkManager = "wpa_cli select_network $(wpa_cli list_networks | tail -n +3 | awk '!seen[$2]++' | rofi -dmenu -window-title 'Select Network' | awk '{print $1;}')"

screenshot = "mkdir -p ~/Screenshots && maim | tee ~/Screenshots/\"$(date --rfc-3339=seconds)\".png | xclip -select clipboard -t image/png"
selectScreenshot = "mkdir -p ~/Screenshots && maim -us | tee ~/Screenshots/\"$(date --rfc-3339=seconds)\".png | xclip -select clipboard -t image/png"

modifierKey = mod4Mask  -- Use Super as our mod key

statusBar = "pkill polybar; polybar main; ${{builtins.concatStringsSep '' '' (map (num: ''polybar DP-'' + toString num + ''; '')(lib.range 1 8))}} polybar HDMI-A-1-0; polybar HDMI-A-1"
compositor = "pkill picom; picom"
background = "pkill show; show -d HDMI-1-1 ~/.xmonad/wallpaper.glsl > /dev/null && show -d eDP-1 ~/.xmonad/wallpaper.glsl > /dev/null"
colorSelection = "xcolor | xclip -sel clip"
keybindings = "setxkbmap -option caps:none && xmodmap ~/.Xmodmap"

shift = shiftMask

-- spell-checker:words xobsock
xobsock = "$XDG_RUNTIME_DIR/xob.sock"

-- workspaces = ["7", "5", "3", "1", "9", "0", "2", "4", "6", "8"];
workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

data NonFloats = NonFloats deriving (Read, Show)

instance SetsAmbiguous NonFloats where
    hiddens _ wset _ _ _ = allWindows wset \\ M.keys (W.floating wset)

startupHook = do
  spawn Main.statusBar
  spawn Main.compositor
  spawn background
  spawn keybindings
  -- windows $ W.view "0"
  spawn "pgrep keepass || run_keepass"
  spawn $ "pkill xob; rm -f " ++ xobsock ++ " && mkfifo " ++ xobsock ++ " && tail -f " ++ xobsock ++ " | xob"

numRowKeys = [xK_bracketleft
            , xK_braceleft
            , xK_braceright
            , xK_parenleft
            , xK_equal
            , xK_asterisk
            , xK_parenright
            , xK_plus
            , xK_bracketright
            , xK_exclam
            ]

main :: IO ()
main = XMonadLog.xmonadLog >>= main'

main' :: D.Client -> IO ()
main' dbus = xmonad
           $ javaHack
           $ ewmh . setEwmhActivateHook doAskUrgent
           $ docks
           $ def
  { modMask = modifierKey  -- Use Super as our mod key
  , borderWidth = 2
  , normalBorderColor = "#61afef"
  , focusedBorderColor = "#61afef"
  , XMonad.terminal = Main.terminal
  , XMonad.workspaces = Main.workspaces
  , XMonad.startupHook = Main.startupHook
  , XMonad.logHook = dynamicLogWithPP (polybarHook dbus)
  , XMonad.layoutHook = lessBorders NonFloats
                      $ (smartSpacing 5

                      $ avoidStruts
                      $ gaps [(U, 5), (D, 5), (L, 5), (R, 5)]
                        $ Grid
                             ||| ResizableTall 1 (3/100) (1/2) []
                             ||| Full
                             ||| Mirror (ResizableTall 1 (3/100) (1/2) []))
                        ||| gaps [(U, 0), (D, 0), (L, 0), (R, 0)] Full
  , XMonad.manageHook = composeAll
                        [ isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DESKTOP"
                          --> hasBorder False <+> doIgnore <+> doLower <+> doLower
                        , checkDock --> doLower <+> doLower
                        , isInProperty "_NET_WM_STATE" "_NET_WM_STATE_MODAL"
                          --> placeHook (withGaps (30, 30, 30, 30) (underMouse (0.5, 0.5))) <+> doFloat
                        ] <+> manageHook def
  , XMonad.handleEventHook = composeAll
                        [ windowedFullscreenFixEventHook
                        , dynamicPropertyChange "_NET_WM_WINDOW_TYPE"
                          (isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DESKTOP"
                          --> hasBorder False <+> doLower
                          <+> (ask >>= \w -> liftX (modifyWindowSet (W.delete w))
                                          >> mempty)
                          <+> (ask >>= \w -> liftX (withDisplay $ \dpy -> io (moveResizeWindow dpy w 0 0 (fromIntegral $ displayWidth dpy $ defaultScreen dpy) (fromIntegral $ displayHeight dpy $ defaultScreen dpy))) >> mempty))
                        ]
                        <+> handleEventHook def
  } `additionalKeys` (
  [ ((modifierKey, xK_d), spawn launcher)
  , ((modifierKey, xK_n), spawn networkManager)
  , ((modifierKey .|. Main.shift, xK_q), kill)
  , ((modifierKey, xK_o), sendMessage MirrorShrink)
  , ((modifierKey, xK_e), sendMessage MirrorExpand)
  , ((modifierKey, xK_q), spawn "xmonad --restart")
  , ((modifierKey .|. Main.shift, xK_c), io exitSuccess)
  , ((modifierKey .|. Main.shift, xK_s), spawn selectScreenshot)
  , ((modifierKey .|. Main.shift, xK_h), spawn colorSelection)
  , ((0, xK_Print), spawn screenshot)
  , ((modifierKey .|. Main.shift, xK_Return), spawn Main.terminal)
  , ((0, xF86XK_AudioLowerVolume), spawn $ volumeChangeCmd ++ " -d")
  , ((0, xF86XK_AudioRaiseVolume), spawn $ volumeChangeCmd ++ " -u")
  , ((0, xF86XK_AudioMute), spawn $ volumeChangeCmd ++ " -m")
  , ((modifierKey, xF86XK_AudioLowerVolume), spawn $ volumeChangeCmd ++ " -d -i")
  , ((modifierKey, xF86XK_AudioRaiseVolume), spawn $ volumeChangeCmd ++ " -u -i")
  , ((modifierKey, xF86XK_AudioMute), spawn $ volumeChangeCmd ++ " -m -i")
  , ((0, xF86XK_MonBrightnessDown), spawn $ "light -U 6 && light -G | cut -d'.' -f1 > " ++ xobsock)
  , ((0, xF86XK_MonBrightnessUp), spawn $ "light -A 6 && light -G | cut -d'.' -f1 > " ++ xobsock)
  , ((modifierKey, xF86XK_MonBrightnessDown), spawn $ "light -U 3 && light -G | cut -d'.' -f1 > " ++ xobsock)
  , ((modifierKey, xF86XK_MonBrightnessUp), spawn $ "light -A 3 && light -G | cut -d'.' -f1 > " ++ xobsock)
  ] ++ (zip numRowKeys Main.workspaces >>= (\(key, workspace) -> [((modifierKey, key), windows $ W.view workspace)
                                                                , ((modifierKey .|. Main.shift, key), windows $ W.shift workspace)
                                                                ])))
