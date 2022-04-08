import XMonad hiding ( (|||) )
import XMonad.Config.Desktop

import XMonad.StackSet as W
import XMonad.ManageHook
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers
import XMonad.Util.NamedScratchpad
import XMonad.Util.ClickableWorkspaces

import XMonad.Actions.Promote
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer

import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Layout.Tabbed
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.LayoutCombinators

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicProperty
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers

import Data.List

three = renamed [Replace "\xfc26"]
	$ noBorders
	$ smartSpacingWithEdge 5
	$ magnifiercz' 1.2
	$ ThreeColMid nmain delta ratio
	where
		nmain = 1
		ratio = 1/2
		delta = 3/100

tiled = renamed [Replace "\xfd33"]
	$ noBorders
	$ smartSpacingWithEdge 5
	$ magnifiercz' 1.2
	$ Tall nmain delta ratio
	where
		nmain = 1
		ratio = 1/2
		delta = 3/100

mtiled = renamed [Replace "\xfd35"]
	$ noBorders
	$ smartSpacingWithEdge 5
	$ magnifiercz' 1.2
	$ Mirror
	$ Tall nmain delta ratio
	where
		nmain = 1
		ratio = 1/2
		delta = 3/100

grid = renamed [Replace "\xf5c6"]
	$ noBorders
	$ smartSpacingWithEdge 5
	$ magnifiercz 1.2
	$ Grid

full = renamed [Replace "\xf792"]
	$ noBorders
	$ Full

tabs = renamed [Replace "\xf9e8"]
	$ tabbed shrinkText _tabtheme


_tabtheme = def
	{ inactiveTextColor = "#d2c4b0"
	, inactiveColor = "#505354"
	, activeBorderWidth = 0
	, activeColor = "#c4b6a3"
	, activeTextColor = "#353839"
	, inactiveBorderWidth = 0
	, urgentColor = "#b38a32"
	, urgentBorderWidth = 0
	, urgentTextColor = "#faebd7"
	, fontName = "xft:Ubuntu:size=11"
	}

_layout = three ||| tiled ||| mtiled ||| grid ||| full ||| tabs

_workspaces :: [String]
_workspaces = [ "1 \xe795", "2 \xf268", "3 \xe795", "4 \xe795", "5 \xf6ed", "6 \xf9b0", "7 \xe70f", "8 \xfa66", "9 \xfc76", "0 \xfc76" ]

_scratchpads :: [NamedScratchpad]
_scratchpads =
	[ NS "scratch" "kitty -T scratch" (title =? "scratch")
		(customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
	, NS "clock" "gnome-clocks" (title =? "Clocks")
		(customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
	]

_manage_app_hook = composeAll . concat $
	[ [ className =? "firefox" --> doShift (_workspaces !! 1) ]
	, [ className =? "google-chrome" --> doShift (_workspaces !! 1) ]
	, [ appName =? "google-chrome" --> doShift (_workspaces !! 1) ]
	, [ className =? "slack" --> doShift (_workspaces !! 5) ]
	, [ appName =? "slack" --> doShift (_workspaces !! 5) ]
	, [ className =? "obsidian" --> doShift (_workspaces !! 5) ]
	, [ className =? "org.remmina.Remmina" --> doShift (_workspaces !! 6) ]
	, [ className =? "outlook.office365.com__owa" --> doShift (_workspaces !! 4) ]
	, [ appName =? "outlook.office365.com__owa" --> doShift (_workspaces !! 4) ]
	, [ isDialog --> doCenterFloat ]
	, [ (className =? zoomClassName) <&&> shouldFloat <$> title --> doFloat ]
	, [ className =? zoomClassName --> doShift (_workspaces !! 7) ]
	, [ appName =? zoomClassName --> doShift (_workspaces !! 7) ]
	, [ zoomMain <$> title --> doShift (_workspaces !! 7) ]
	, [ fmap ( c `isInfixOf`) className <&&> shouldFloat <$> title --> doCenterFloat | c <- floatClasses ]
	, [ fmap ( c `isInfixOf`) title --> doCenterFloat | c <- floatTitles ]
	]
	where
		floatClasses = ["Pavucontrol", "join?"]
		floatTitles = []
		zoomClassName = "zoom "
		tileTitles =
			[ "Zoom - Free Account"
			, "Zoom - Licensed Account"
			, "Zoom Cloud Meetings"
			, "Zoom"
			, "Zoom Meeting"
			]
		shouldFloat title = title `notElem` tileTitles
		zoomMain title = title `elem` tileTitles

_manage_hook =
	_manage_app_hook
	<+> namedScratchpadManageHook _scratchpads
	<+> manageHook def

_event_hook =
	dynamicTitle _manage_app_hook
	<+> handleEventHook def

_log_hook =
	updatePointer (0.5, 0.15) (0, 0)

_config = desktopConfig
	{ modMask = mod4Mask
	, terminal = "kitty"
	, borderWidth = 0
	, XMonad.workspaces = _workspaces
	, startupHook = _startup
	, layoutHook = _layout
	, manageHook = _manage_hook
	, handleEventHook = _event_hook
	, logHook = _log_hook
	}
	`additionalKeysP`
	_keys

_keys =
	[ ("M-<Return>", spawn "kitty")
	, ("M-s", windows $ swapMaster . focusDown)
	, ("M-S-<Return>", promote)
	, ("M-S-t", sendMessage $ JumpToLayout "\xf9e8")
	, ("M-f", sendMessage $ JumpToLayout "\xf792")
	, ("M-r", spawn "rofi -modi window,drun,ssh,combi -show combi")
	, ("M-p", namedScratchpadAction _scratchpads "scratch")
	, ("M-w", namedScratchpadAction _scratchpads "clock")
	, ("M-v", spawn "~/bin/pass-notify")
	, ("M-c", spawn "flameshot launcher")
	]
	++
	[ (otherModMasks ++ "M-" ++ [key], action tag)
		| (tag, key)  <- zip _workspaces "1234567890"
			, (otherModMasks, action) <- [ ("", toggleOrView)
		, ("S-", windows . shift)]
	]

_startup = do
	spawnOnce "~/.local/bin/xmobar ~/.config/xmonad/xmobarrc.workspaces"
	spawnOnce "~/.local/bin/xmobar ~/.config/xmonad/xmobarrc.center"
	spawnOnce "xbindkeys"
	spawnOnce "dunst"
	spawnOnce "feh --bg-fill ~/.config/background.png"
	spawnOnce "picom --experimental-backends -b"
	spawnOnce "stalonetray --sticky --skip-taskbar --geometry 8x1-0+0 -bg \"#353839\" -i 22 -s 30"
	spawnOnce "pasystray"
	spawnOnce "nm-applet"

_xmobar_pp :: PP
_xmobar_pp = def
	{ ppSep = cyan " | "
	, ppTitleSanitize = xmobarStrip
	, ppCurrent = xmobarBorder "Top" "#5396a6" 2 . pad
	, ppHidden = fg . pad
	, ppHiddenNoWindows = fgOff . pad
	, ppUrgent = red . wrap (yellow "!") (yellow "!")
	, ppOrder = \[ws, l, _] -> [ws, l]
	}
	where
		cyan, red, fg, fgOff, yellow :: String -> String
		cyan = xmobarColor "#377c8b" ""
		fg = xmobarColor "#faebd7" ""
		fgOff = xmobarColor "#5c5f60" ""
		yellow = xmobarColor "#d0a44c" ""
		red = xmobarColor "#f85e89" ""

main :: IO ()
main = xmonad
	. ewmhFullscreen
	. ewmh
	. withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (clickablePP (filterOutWsPP [scratchpadWorkspaceTag] _xmobar_pp))) defToggleStrutsKey
	$ _config

