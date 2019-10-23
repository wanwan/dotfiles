import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import XMonad.Actions.WindowGo

import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Layout.Named



-- define default terminal
myTerminal = "/usr/bin/urxvt -e screen"

-- define mod key
--myModMask = mod1Mask -- Alt_L
--myModMask = mod3Mask
myModMask = mod4Mask

-- define window border
myBorderWidth = 3

-- define workspace
myWorkspaces = [ "shell"
	       ,"editor"
	       ,"browser"
	       ,"idea"
	       ,"vm"
	       ,"chat"
	       ,"media"
	       ,"game"
	       ,"system" ]


--tall = Tall 1 (3/100) (1/2)

{-|
main = do
        xmproc <- spawnPipe "/usr/bin/xmobar /home/waka/.xmobarrc"
        xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        --, layoutHook = avoidStruts  $  layoutHook defaultConfig
    , layoutHook = mkToggle1 FULL $ desktopLayoutModifiers (named "V" tall ||| (named "H" $ Mirror tall))

      -- sometimes, xmonad freese,comment out these lines 
          -- , logHook = dynamicLogWithPP $ xmobarPP
          -- { ppOutput = hPutStrLn xmproc
          --    , ppTitle = xmobarColor "green" "" . shorten 50
          -- }

          -- Border settings
      , borderWidth = 2
          , normalBorderColor  = "#99ccff"
          , focusedBorderColor = "#0033dd" -- blue

          -- Rebind Mod to the Hiragana_Katakana 
      , modMask = mod3Mask
      -- , modMask = mod1Mask        

          -- use rxvt-unicode 
      , terminal = "urxvt" 
          }
          -- windows キーでショートカット
          `additionalKeys`
          [
            ((modm, xK_l), spawn "gnome-screensaver-command -l")
          , ((modm, xK_t), runOrRaise "urxvt" (className =? "URxvt"))
          , ((modm, xK_k), runOrRaise "conkeror" (className =? "conkeror"))
      , ((modm, xK_f), sendMessage (Toggle FULL))
          , ((modm, xK_q), spawn "xinput --set-prop \"SynPS/2 Synaptics TouchPad\" \"Device Enabled\" 0")
          , ((modm, xK_w), spawn "xinput --set-prop \"SynPS/2 Synaptics TouchPad\" \"Device Enabled\" 1")
          ]

-}


main = xmonad =<< xmobar defaultConfig
        { terminal = myTerminal
        , modMask = myModMask
        , borderWidth = myBorderWidth
        , workspaces	= myWorkspaces
        }
