import XMonad

import XMonad.StackSet
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce

import XMonad.Actions.Promote

import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

_layout = noBorders tiled ||| noBorders (Mirror tiled) ||| noBorders Full ||| noBorders threeColumns
	where
		threeColumns = magnifiercz' 1.3 $ ThreeColMid nmain delta ratio
		tiled = magnifiercz' 1.3 $ Tall nmain delta ratio
		nmain = 1
		ratio = 1/2
		delta = 3/100

_config = def
	{ modMask = mod4Mask
	, terminal = "kitty"
	, startupHook = _startup
	, layoutHook = smartSpacingWithEdge 5 $ _layout
	}
	`additionalKeysP`
	[ ("M-<Return>", spawn "kitty")
	, ("M-S-f", spawn "firefox")
	, ("M-s", windows $ swapMaster . focusDown)
	, ("M-S-<Return>", promote)
	]

_startup = do
	spawnOnce "xmobar ~/.config/xmonad/xmobarrc"
	spawnOnce "xbindkeys"
	spawnOnce "feh --bg-fill ~/.config/background.png"
	spawnOnce "picom --experimental-backends -b"

_xmobar_pp :: PP
_xmobar_pp = def

main :: IO ()
main = xmonad
	. ewmhFullscreen
	. ewmh
	. withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (pure _xmobar_pp)) defToggleStrutsKey
	$ _config
