-- standard requires
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- custom requires
local errors = require("misc.errors")
local workspace = require("misc.workspace")
local input = require("misc.input")
local autostart = require("misc.autostart")

-- defines and stuff
terminal = "kitty"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

errors.init()
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/zengarden-dark/theme.lua")
beautiful.master_width_factor = 0.7

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.fair,
	awful.layout.suit.floating,
	awful.layout.suit.tile.top,
	awful.layout.suit.max,
}

screen.connect_signal("property::geometry", workspace.set_wallpaper)

awful.screen.connect_for_each_screen(workspace.setup)

root.buttons(input.root_buttons())
root.keys(input.global_keys(modkey))

awful.rules.rules = {
	{
		rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = input.client_keys,
			buttons = input.client_buttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		}
	},
	{
		rule = { class = "zoom " },
		properties = {
			tag = awful.screen.focused().tags[8],
			switchtotag = true,
		}
	},
}

client.connect_signal("manage", function (c)
	if awesome.startup
		and not c.size_hints.user_position
		and not c.size_hints.program_position
	then
			awful.placement.no_offscreen(c)
	end
end)

client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
	c:raise()
end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

autostart.init()

dofile(gears.filesystem.get_configuration_dir() .. "private.lua")
