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

-- define default terminal
myTerminal = "urxvt -e screen"

-- define mod key
myModMask = mod4Mask -- Win key or Super_L

-- define window border
myBorderWidth = 3

-- define workspace
myWorkspaces = [ "shell"
	       ,"editor"
	       ,"browser"
	       ,"idea"
	       ,"vm"
	       ,"media"
	       ,"7"
	       ,"8"
	       ,"9"]

myStartupHook :: X()
myStartupHook = do
  setWMName "LG3D"
  --spawnOn "editor" "emacs"
  --spawnOn "browser" "google-chrome-stable --force-device-scale-factor=2"
  --spawnOn "idea" "intellij-idea-ultimate-edition"  

myManageHook = composeAll . concat $
  [ [ className =? "Emacs" --> doShift "editor" ]
--  , [ className =? "Google-chrome" --> doShift "browser" ]
  , [ className =? "jetbrains-idea" --> doShift "idea" ]
  , [ className =? "skypeforlinux" --> doShift "media" ]
  , [ className =? "whatsapp-desktop" --> doShift "media" ]
--  , [ className =? "net-minecraft-launcher-Main" --> doShift "media" | doFloat]
--  , [ className =? "Minecraft 1.12.2" --> doShift "media" | doFloat]
  ]


-- Define ShortCuts
myShortCuts = [
--    ((mod4Mask, xK_l), spawn "slock"),
--    ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +20"),
--    ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -20"),
      ((mod4Mask, xK_c), spawn "google-chrome-stable")
--    ((mod4Mask, xK_m), spawn "mysql-workbench"),
--    ((mod4Mask, xK_t), spawn "thunderbird"),
--    ((mod4Mask, xK_a), spawn "sleep 0.2; scrot -s -e 'mv $f /data/samba/shots/'"),
    , ((mod4Mask, xK_b), sendMessage ToggleStruts)
--    ((mod1Mask, xK_Tab), goToSelected def),
--    ((mod1Mask, xK_p), shellPrompt myXmonadPromptConfig)
    ]


--my_dzen_PP h = defaultPP
my_dzen_PP h = dzenPP
       { 
         ppOutput          = hPutStrLn h
       }  


myXmonadBar = "dzen2 -x '0' -y '0' -h '32' -w '1600' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E' -fn 'terminus-12' -dock"
myStatusBar = "LC_TIME=C conky -c /home/waka/.xmonad/conkyrc | dzen2 -x '1600' -w '1600' -h '32' -ta 'r' -bg '#1B1D1E' -fg '#FFFFFF' -y '0' -fn 'terminus-12' -dock"


--customLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full ||| simpleFloat
--  where
--    tiled   = ResizableTall 1 (2/100) (1/2) []
customLayout = avoidStruts (tiled) ||| Full 
  where
    tiled = ResizableTall 1 (2/100) (1/2) []
--customLayout = Full ||| avoidStruts simpleFloat


main = do
  dzenLeftBar <- spawnPipe myXmonadBar
  spawn myStatusBar
  --xmonad $ defaultConfig
  xmonad $ desktopConfig   
     { terminal		= myTerminal
     , modMask		= myModMask
     , borderWidth	= myBorderWidth
     , workspaces	= myWorkspaces     
--     , manageHook       = myManageHook <+> manageHook defaultConfig <+> manageDocks
     , manageHook       = myManageHook <+> manageHook desktopConfig <+> manageDocks     
--     , startupHook      = myStartupHook <+> docksStartupHook
     , startupHook      = myStartupHook <+> docksStartupHook     
     , layoutHook       = customLayout
     , logHook          = dynamicLogWithPP $ my_dzen_PP dzenLeftBar
     , handleEventHook  = docksEventHook
--     , handleEventHook  = docksEventHook <+> fullscreenEventHook
     } `additionalKeys` myShortCuts
