-- spell-checker:words xmonad,dbus,polybar,mempty

module XMonadLog where

import qualified DBus                          as D
import qualified DBus.Client                   as D

import qualified Codec.Binary.UTF8.String      as UTF8
import           XMonad.Actions.WorkspaceNames (workspaceNamesPP)
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Util.Replace           (replace)

xmonadLog :: IO D.Client
xmonadLog = let opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  in do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.Log") opts
  return dbus

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let objectPath  = D.objectPath_ "/org/xmonad/Log"
      interfaceName  = D.interfaceName_ "org.xmonad.Log"
      memberName  = D.memberName_ "Update"
      signal = D.signal objectPath interfaceName memberName
      body   = [D.toVariant str]
  in D.emit dbus $ signal { D.signalBody = body }

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
                  | otherwise  = mempty
      blue   = "#61afef"
      grey   = "#474e5d"
      orange = "#e5c07b"
      purple = "#c678dd"
      green  = "#98c379"
      red    = "#e06c75"
  in def { ppOutput          = dbusOutput dbus
         , ppCurrent         = wrapper red
         , ppVisible         = wrapper orange
         , ppUrgent          = wrapper green
         , ppHidden          = wrapper blue
         , ppHiddenNoWindows = wrapper grey
         , ppTitle           = shorten 100 . wrapper purple
         }
