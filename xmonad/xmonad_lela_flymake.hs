import XMonad
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


tall = Tall 1 (3/100) (1/2)

main = 	xmonad defaultConfig
	{ 
		manageHook = manageDocks <+> manageHook defaultConfig,
		layoutHook = mkToggle1 FULL $ desktopLayoutModifiers (named "V" tall ||| (named "H" $ Mirror tall)),
		borderWidth = 2,
		normalBorderColor  = "#99ccff",
		focusedBorderColor = "#0033dd", -- blue
		modMask = myModMask,
		terminal = myTerminal
          }

