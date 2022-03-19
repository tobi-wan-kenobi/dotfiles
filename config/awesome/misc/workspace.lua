local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- custom requires
local taglist = require("misc.taglist")
--local bountiful = require("bountiful")

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

	local clock = wibox.container.margin(wibox.widget.textclock("%a %b %d, %H:%M %Z"), 10, 10)

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
			clock,
			wibox.container.margin(screen.layoutbox, 10, 10, 5, 6),
		}
	}
	local clock_popup = awful.popup {
		ontop = true,
		visible = false,
		shape = gears.shape.rounded_rect,
		border_width = 2,
		border_color = beautiful.fg_normal,
		offset = 2,
		preferred_anchors = "middle",
		preferred_positions = "bottom",
		widget = {
				layout = wibox.layout.fixed.vertical,
				wibox.container.margin(wibox.widget.textclock("%a %b %d, %H:%M %Z", 60, "Europe/London"), 10, 10, 10, 10),
				wibox.container.margin(wibox.widget.textclock("%a %b %d, %H:%M %Z", 60, "America/Los_Angeles"), 10, 10, 10, 10),
		}
	}
	clock:connect_signal("mouse::enter", function()
		clock_popup.visible = true
		clock_popup:move_next_to(mouse.current_widget_geometry)
	end)
	clock:connect_signal("mouse::leave", function()
		clock_popup.visible = false
	end)
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
