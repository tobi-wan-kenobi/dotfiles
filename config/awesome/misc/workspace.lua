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

	awful.tag.add(" \u{e795} ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
		selected = true,
	})
	awful.tag.add(" \u{f268} ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add(" \u{e795} ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add(" \u{e795} ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add(" \u{f6ed} ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add(" \u{f9b0} ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add(" \u{e70f} ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add(" \u{fa66} ", {
		layout             = awful.layout.suit.floating,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add(" \u{fa66} ", {
		layout             = awful.layout.suit.tile,
		gap_single_client  = false,
		screen             = screen,
	})
	awful.tag.add(" \u{fc76} ", {
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

	screen.wibox = awful.wibar({ position = "top", screen = screen, height=28 })

	screen.wibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			screen.taglist,
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
				{
					layout = wibox.container.margin,
					top = 2,
					bottom = 2,
					{
						layout = wibox.layout.fixed.horizontal,
						spacing = 0,
						--bountiful.battery({ show_always = true }),
						bountiful.arch({ }),
						bountiful.cpu({ }),
						bountiful.memory({ }),
						bountiful.pamixer({ show_always = true }),
						bountiful.pamixer({ source = true, show_always = true }),
						bountiful.clock({
							format = "%a %b %d, %H:%M %Z",
							timezones = { "Europe/Vienna", "Europe/London", "America/Los_Angeles" },
              show_always = true,
						}),
					},
				},
				wibox.widget.systray(),
				screen.layoutbox,
				spacing = 0
			}
		}
	}
	bountiful.events:init({
		pulseaudio = true,
		cpu = true,
	})

end

return workspace
