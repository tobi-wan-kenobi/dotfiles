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

	awful.tag.add("1  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
		selected = true,
	})
	awful.tag.add("2  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("3  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("4  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("5  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("6  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("7  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("8  ", {
		layout             = awful.layout.suit.floating,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("9  ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add("0  ", {
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
			screen.taglist,
			bountiful.focus({ margin = 10 }),
			buttons = gears.table.join(
				awful.button({ }, 5, function()
					awful.tag.viewnext(screen)
				end),
				awful.button({ }, 4, function()
					awful.tag.viewprev(screen)
				end)
			)
		},
		{
			layout = wibox.layout.fixed.horizontal,
			buttons = gears.table.join(
				awful.button({ }, 5, function()
					awful.tag.viewnext(screen)
				end),
				awful.button({ }, 4, function()
					awful.tag.viewprev(screen)
				end)

			),
		},
		{
			layout = wibox.container.margin,
			top = 2,
			bottom = 2,
			{
				layout = wibox.layout.fixed.horizontal,
				top = 2,
				bottom = 2,
				bountiful.cpu({ margin = 10 }),
				bountiful.memory({ margin = 10 }),
				bountiful.arch({ margin = 10 }),
				bountiful.pamixer({ margin = 10 }),
				bountiful.pamixer({ source = true, margin = 10 }),
				bountiful.clock({
					format = "%a %b %d, %H:%M %Z",
					additional_timezones = { "Europe/London", "America/Los_Angeles" },
					margin = 10,
				}),
				wibox.widget.systray(),
				screen.layoutbox,
				spacing = 5
			}
		}
	}
	bountiful.events:init({
		pulseaudio = true,
		cpu = true,
	})

end

return workspace
