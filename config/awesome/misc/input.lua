local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local input = {}

function view_tag_only(i)
	local screen = awful.screen.focused()
	local tag = screen.tags[i]

	if tag == screen.selected_tag then
		tag = screen.previous_tag
	end
	screen.previous_tag = screen.selected_tag
	if tag then
		tag:view_only()
	end
end

function input.root_buttons()
	return gears.table.join(
		awful.button({ }, 5, awful.tag.viewnext),
		awful.button({ }, 4, awful.tag.viewprev)
	)
end

function input.global_keys(modkey)
	local globalkeys = gears.table.join(
		awful.key({ modkey }, "o",
			hotkeys_popup.show_help,
			{ description="show help", group="awesome" }
		),
		awful.key({ modkey }, "j",
			function () awful.client.focus.byidx(1) end,
			{ description = "focus next by index", group = "client" }
		),
		awful.key({ modkey }, "k",
			function () awful.client.focus.byidx(-1) end,
			{ description = "focus previous by index", group = "client" }
		),
		awful.key({ modkey, "Shift" }, "j",
			function () awful.client.swap.byidx(1) end,
			{ description = "swap with next client by index", group = "client" }
		),
		awful.key({ modkey, "Shift" }, "k",
			function () awful.client.swap.byidx( -1) end,
			{ description = "swap with previous client by index", group = "client" }
		),
		awful.key({ modkey }, "u",
			awful.client.urgent.jumpto,
			{ description = "jump to urgent client", group = "client" }
		),
		awful.key({ modkey }, "Tab",
			function ()
				awful.client.focus.history.previous()
				if client.focus then
					client.focus:raise()
				end
			end,
			{ description = "go back", group = "client" }
		),

		awful.key({ modkey }, "Return",
			function () awful.spawn(terminal) end,
			{ description = "open a terminal", group = "launcher" }
		),
		awful.key({ modkey, "Control" }, "r",
			awesome.restart,
			{ description = "reload awesome", group = "awesome" }
		),
		awful.key({ modkey, "Shift" }, "q",
			awesome.quit,
			{ description = "quit awesome", group = "awesome" }
		),

		awful.key({ modkey }, "l",
			function () awful.tag.incmwfact(0.05) end,
			{ description = "increase master width factor", group = "layout" }
		),
		awful.key({ modkey }, "h",
			function () awful.tag.incmwfact(-0.05) end,
			{ description = "decrease master width factor", group = "layout" }
		),
		awful.key({ modkey, "Shift" }, "h",
			function () awful.tag.incnmaster(1, nil, true) end,
			{ description = "increase the number of master clients", group = "layout" }
		),
		awful.key({ modkey, "Shift" }, "l",
			function () awful.tag.incnmaster(-1, nil, true) end,
			{ description = "decrease the number of master clients", group = "layout" }
		),
		awful.key({ modkey }, "space",
			function () awful.layout.inc(1) end,
			{ description = "select next", group = "layout" }
		),
		awful.key({ modkey, "Shift" }, "space",
			function () awful.layout.inc(-1) end,
			{ description = "select previous", group = "layout" }
		),
		awful.key({ modkey }, "c",
			function()  awful.spawn("flameshot launcher") end,
			{ description = "take screenshot with flameshot", group="launcher" }
		),

		awful.key({ modkey }, "r",
			function () awful.spawn(gears.filesystem.get_xdg_config_home () .. "/rofi/launchers/misc/launcher.sh") end,
			{ description = "run applications", group = "launcher" }
		),
		awful.key({ modkey }, "y",
			function () awful.spawn(gears.filesystem.get_xdg_config_home () .. "/rofi/powermenu/powermenu.sh") end,
			{ description = "show power menu", group = "launcher" }
		)
	)
	for i = 1, 10 do
		local num = tostring(i % 10)
		globalkeys = gears.table.join(globalkeys,
			awful.key({ modkey }, num,
				function () view_tag_only(i) end,
				{ description = "view tag #"..num, group = "tag" }
			),
			-- Toggle tag display.
			awful.key({ modkey, "Control" }, num,
				function ()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						awful.tag.viewtoggle(tag)
					end
				end,
				{ description = "toggle tag #" .. num, group = "tag" }
			),
			-- Move client to tag.
			awful.key({ modkey, "Shift" }, num,
				function ()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:move_to_tag(tag)
						end
					end
				end,
				{ description = "move focused client to tag #"..num, group = "tag" }
			),
			-- Toggle tag on focused client.
			awful.key({ modkey, "Control", "Shift" }, num,
				function ()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:toggle_tag(tag)
						end
					end
				end,
				{ description = "toggle focused client on tag #" .. num, group = "tag" }
			)
		)
	end
	return globalkeys
end

function input.client_keys()
	return gears.table.join(
		awful.key({ modkey }, "f",
			function (c)
				c.fullscreen = not c.fullscreen
				c:raise()
			end,
			{ description = "toggle fullscreen", group = "client" }
		),
		awful.key({ modkey, "Shift" }, "c",
			function (c) c:kill() end,
			{ description = "close", group = "client" }
		),
		awful.key({ modkey, "Shift" }, "f",
			awful.client.floating.toggle,
			{ description = "toggle floating", group = "client" }
		),
		awful.key({ modkey, "Shift" }, "Return",
			function (c) c:swap(awful.client.getmaster()) end,
			{ description = "move to master", group = "client" }
		),
		awful.key({ modkey }, "s",
			function(c)
				awful.client.swap.byidx(1, c)
				awful.client.focus.byidx(-1)
			end,
			{ description = "swap master with next window", group="client" }
		),
		awful.key({ modkey }, "f",
			function (c)
				c.maximized = not c.maximized
				c:raise()
			end,
			{ description = "(un)maximize", group = "client" }
		)
	)
end

function input.client_buttons()
	return gears.table.join(
		awful.button({ }, 1,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
			end
		),
		awful.button({ modkey }, 1,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
				awful.mouse.client.move(c)
			end
		),
		awful.button({ modkey }, 3,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
				awful.mouse.client.resize(c)
			end
		)
	)
end

return input
