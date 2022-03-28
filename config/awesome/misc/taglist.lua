local awful = require("awful")
local gears = require("gears")

local taglist = {}

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

function taglist.taglist(screen)
	local taglist_buttons = gears.table.join(
		awful.button({ }, 1, function(t)
			view_tag_only(t.index)
		end),
		awful.button({ modkey }, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
		awful.button({ }, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end)
	)
	return awful.widget.taglist {
		screen = screen,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	}
end

return taglist
