import XMonad hiding ( (|||) )

import XMonad.StackSet (focusDown, swapMaster)
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
_workspaces = [ "1 \xe795", "2 \xf269", "3 \xe795", "4 \xe795", "5 \xf6ed", "6 \xf9b0", "7 \xf17a", "8 \xf03d", "9 \xfc76", "0 \xfc76" ]

_config = def
	{ modMask = mod4Mask
	, terminal = "kitty"
	, borderWidth = 0
	, workspaces = _workspaces
	, startupHook = _startup
	, layoutHook = _layout
	}
	`additionalKeysP`
	[ ("M-<Return>", spawn "kitty")
	, ("M-s", windows $ swapMaster . focusDown)
	, ("M-S-<Return>", promote)
	, ("M-t", sendMessage $ JumpToLayout "\xf9e8")
	, ("M-f", sendMessage $ JumpToLayout "\xf792")
	]

_startup = do
	spawnOnce "/home/twitek/.local/bin/xmobar ~/.config/xmonad/xmobarrc"
	spawnOnce "xbindkeys"
	spawnOnce "feh --bg-fill ~/.config/background.png"
	spawnOnce "picom --experimental-backends -b"

_xmobar_pp :: PP
_xmobar_pp = def
	{ ppSep = magenta " | "
	, ppTitleSanitize = xmobarStrip
	, ppCurrent = xmobarBorder "Top" "#5396a6" 2 . wrap " " " "
	, ppHidden = fg . wrap " " " "
	, ppHiddenNoWindows = fg . wrap " " " "
	, ppUrgent = red . wrap (yellow "!") (yellow "!")
	, ppOrder = \[ws, l, _] -> [ws, l]
	}
	where
	cyan, blue, lowWhite, magenta, red, fg, yellow :: String -> String
	cyan = xmobarColor "#377c8b" ""
	magenta = xmobarColor "#ff79c6" ""
	blue = xmobarColor "#bd93f9" ""
	fg = xmobarColor "#faebd7" ""
	yellow = xmobarColor "#f1fa8c" ""
	red = xmobarColor "#ff5555" ""
	lowWhite = xmobarColor "#bbbbbb" ""

main :: IO ()
main = xmonad
	. ewmhFullscreen
	. ewmh
	. withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (pure _xmobar_pp)) defToggleStrutsKey
	$ _config
