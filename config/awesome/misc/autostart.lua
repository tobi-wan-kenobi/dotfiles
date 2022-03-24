local awful = require("awful")

local autostart = {}

local function run_once(cmd)
	pattern = cmd:match("(%S+)")
	awful.spawn.with_shell(string.format(
		"pgrep -u $USER -x %s > /dev/null || (%s)", pattern, cmd
	))
end

function autostart.init()
	run_once("xbindkeys")
	run_once("picom --experimental-backends")
end

return autostart
