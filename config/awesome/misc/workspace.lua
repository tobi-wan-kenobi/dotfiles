local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- custom requires
local taglist = require("misc.taglist")
local bountiful = require("bountiful")

local workspace = {}

function workspace.set_wallpaper(screen)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(screen)
		end
		gears.wallpaper.maximized(wallpaper, screen, true)
	end
end

function workspace.setup(screen)
	workspace.set_wallpaper(screen)

	awful.tag.add("  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
		selected = true,
	})
	awful.tag.add("  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("  ", {
		layout             = awful.layout.suit.floating,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})

	screen.layoutbox = awful.widget.layoutbox(screen)
	screen.layoutbox:buttons(gears.table.join(
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
		awful.button({ }, 3, function () awful.layout.inc(-1) end),
		awful.button({ }, 4, function () awful.layout.inc( 1) end),
		awful.button({ }, 5, function () awful.layout.inc(-1) end)
	))
	screen.taglist = taglist.taglist(screen)

	screen.wibox = awful.wibar({ position = "top", screen = screen })

	screen.wibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			screen.taglist
		},
		{
			layout = wibox.layout.fixed.horizontal,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			bountiful.clock({
				format = "%a %b %d, %H:%M %Z",
				additional_timezones = { "Europe/London", "America/Los_Angeles" }
			}),
			wibox.container.margin(screen.layoutbox, 10, 10, 5, 6),
		}
	}
	screen.wibox:buttons(gears.table.join(
		awful.button({ }, 5, function()
			awful.tag.viewnext(screen)
		end),
		awful.button({ }, 4, function()
			awful.tag.viewprev(screen)
		end)
	))
end
return workspace
