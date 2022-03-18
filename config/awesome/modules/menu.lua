local awful = require("awful")
local beautiful = require("beautiful")

local menu = {}

function menu.main()
	os_menu = {
		{ "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
		{ "manual", terminal .. " -e man awesome" },
		{ "edit config", editor_cmd .. " " .. awesome.conffile },
		{ "restart", awesome.restart },
		{ "quit", function() awesome.quit() end },
	}

	app_menu = {
		{ "terminal", terminal },
	}

	return awful.menu({
		items = {
			{ "awesome", os_menu, beautiful.awesome_icon },
			{ "applications", app_menu },
		}
	})
end

return menu
