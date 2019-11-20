import System.IO
import System.Exit

import XMonad
import XMonad.Util.Run
import XMonad.Config.Desktop
import XMonad.Hooks.SetWMName
import XMonad.Actions.SpawnOn
import XMonad.Layout.SimpleFloat
import XMonad.Layout.ResizableTile
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.EwmhDesktops
--import XMonad.Hooks.DynamicLog
--import XMonad.Hooks.ManageDocks
--import XMonad.Util.Run(spawnPipe)
--import XMonad.Util.EZConfig(additionalKeys)
--import System.IO

--import XMonad.Actions.WindowGo

--import XMonad.Layout.MultiToggle
--import XMonad.Layout.MultiToggle.Instances
--import XMonad.Config.Desktop (desktopLayoutModifiers)
--import XMonad.Layout.Named


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
	       ,"slack"
	       ,"vm"
	       ,"chat"
	       ,"media"
	       ,"game"
	       ,"system" ]

myStartupHook :: X()
myStartupHook = do
  setWMName "LG3D"
  spawnOn "shell" "urxvt -e screen"
  spawnOn "editor" "emacs"
  spawnOn "browser" "google-chrome-stable"
  --spawnOn "browser" "google-chrome-stable --force-device-scale-factor=2"
  --spawnOn "idea" "intellij-idea-ultimate-edition"  

tall = Tall 1 (3/100) (1/2)

main = 	xmonad defaultConfig
	{ 
		borderWidth = 2,
		normalBorderColor  = "#99ccff",
		focusedBorderColor = "#ff0000", -- blue
		modMask = myModMask,
                startupHook      = myStartupHook <+> docksStartupHook,
		terminal = myTerminal

        }
