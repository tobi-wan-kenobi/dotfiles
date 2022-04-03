import XMonad hiding ( (|||) )

import XMonad.StackSet (focusDown, swapMaster, swapDown, sink)
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers

import XMonad.Actions.Promote

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

three = renamed [Replace "\xfc26"]
	$ noBorders
	$ smartSpacingWithEdge 5
	$ magnifiercz' 1.3
	$ ThreeColMid nmain delta ratio
	where
		nmain = 1
		ratio = 1/2
		delta = 3/100

tiled = renamed [Replace "\xfd33"]
	$ noBorders
	$ smartSpacingWithEdge 5
	$ magnifiercz' 1.3
	$ Tall nmain delta ratio
	where
		nmain = 1
		ratio = 1/2
		delta = 3/100

mtiled = renamed [Replace "\xfd35"]
	$ noBorders
	$ smartSpacingWithEdge 5
	$ magnifiercz' 1.3
	$ Mirror
	$ Tall nmain delta ratio
	where
		nmain = 1
		ratio = 1/2
		delta = 3/100

grid = renamed [Replace "\xf5c6"]
	$ noBorders
	$ smartSpacingWithEdge 5
	$ magnifiercz 1.3
	$ Grid

full = renamed [Replace "\xf792"]
	$ noBorders
	$ Full

tabs = renamed [Replace "\xf9e8"]
	$ simpleTabbed

_layout = three ||| tiled ||| mtiled ||| grid ||| full ||| tabs

_workspaces :: [String]
_workspaces = [ "1 \xe795", "2 \xf738", "3 \xe795", "4 \xe795", "5 \xf6ed", "6 \xf9b0", "7 \xe70f", "8 \xfa66", "9 \xfc76", "0 \xfc76" ]


_manage_zoom_hook =
	composeAll $
	[ (className =? zoomClassName) <&&> shouldFloat <$> title --> doFloat
	, (className =? zoomClassName) <&&> shouldSink <$> title --> doSink
	, (className =? zoomClassName) --> doShift "8 \xfa66"
	]
	where
		zoomClassName = "zoom "
		tileTitles =
			[ "Zoom - Free Account"
			, "Zoom - Licensed Account"
			, "Zoom Cloud Meetings"
			, "Zoom"
			, "Zoom Meeting"
			]
		shouldFloat title = title `notElem` tileTitles
		shouldSink title = title `elem` tileTitles
		doSink = (ask >>= doF . sink) <+> doF swapDown

_manage_hook =
	_manage_zoom_hook
	<+> manageHook def

_event_hook =
	mconcat
		[ dynamicTitle _manage_zoom_hook
		, handleEventHook def
		]

_config = def
	{ modMask = mod4Mask
	, terminal = "kitty"
	, borderWidth = 0
	, workspaces = _workspaces
	, startupHook = _startup
	, layoutHook = _layout
	, manageHook = _manage_hook
	, handleEventHook = _event_hook
	}
	`additionalKeysP`
	[ ("M-<Return>", spawn "kitty")
	, ("M-s", windows $ swapMaster . focusDown)
	, ("M-S-<Return>", promote)
	, ("M-t", sendMessage $ JumpToLayout "\xf9e8")
	, ("M-f", sendMessage $ JumpToLayout "\xf792")
	]

_startup = do
	spawnOnce "killall xmobar && /home/twitek/.local/bin/xmobar ~/.config/xmonad/xmobarrc"
	spawnOnce "killall xbindkeys && xbindkeys"
	spawnOnce "feh --bg-fill ~/.config/background.png"
	spawnOnce "killall picom && picom --experimental-backends -b"
	spawnOnce "killall stalonetray && stalonetray --sticky --skip-taskbar --geometry 8x1-0+0 -bg \"#353839\" -i 19 -s 24"

_xmobar_pp :: PP
_xmobar_pp = def
	{ ppSep = cyan " | "
	, ppTitleSanitize = xmobarStrip
	, ppCurrent = xmobarBorder "Top" "#5396a6" 2 . wrap " " " "
	, ppHidden = fg . wrap " " " "
	, ppHiddenNoWindows = fgOff . wrap " " " "
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
	. withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (pure _xmobar_pp)) defToggleStrutsKey
	$ _config
