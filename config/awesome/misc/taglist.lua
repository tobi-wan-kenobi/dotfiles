local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

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
	local theme = beautiful.get()
	return awful.widget.taglist {
		screen = screen,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		style = {
			fg_focus = theme.colors.fg,
			fg_urgent = theme.colors.fg,
			bg_urgent = '',
			bg_focus = '',
		},
		widget_template = {
			{
				{
					{
						{
							left = 10,
							right = 10,
							widget = wibox.container.margin
						},
						id = 'overline',
						shape = gears.shape.rounded_rect,
						forced_height = 3,
						widget = wibox.container.background
					},
					{
						{
							{
								{
									id     = 'index_role',
									widget = wibox.widget.textbox,
								},
								left = 2,
								right = 2,
								widget  = wibox.container.margin,
							},
							{
								id     = 'text_role',
								widget = wibox.widget.textbox,
							},
							layout = wibox.layout.fixed.horizontal,
						},
						widget = wibox.container.margin,
						bottom = 1,
						top = 1,
					},
					{
						{
							left = 10,
							right = 10,
							widget = wibox.container.margin
						},
						id = 'underline',
						shape = gears.shape.rounded_rect,
						forced_height = 3,
						widget = wibox.container.background
					},
					layout = wibox.layout.fixed.vertical,
				},
				left  = 2,
				right = 2,
				widget = wibox.container.margin
			},
			id     = 'background_role',
			widget = wibox.container.background,
			-- Add support for hover colors and an index label
			create_callback = function(self, c3, index, objects) --luacheck: no unused args
				local tag = awful.screen.focused().tags[index]
				tag:connect_signal('property::urgent', function()
					tag.is_urgent = true
					self:get_children_by_id("underline")[1].bg = theme.colors.red
				end)
				--self:connect_signal('mouse::enter', function()
				--local child = self:get_children_by_id("underline")[1]
				--	child.prev_bg = child.bg
				--	child.bg = self.fg
				--end)
				--self:connect_signal('mouse::leave', function()
				--	local child = self:get_children_by_id("underline")[1]
				--	child.bg = child.prev_bg
				--end)
				self:update_callback(c3, index, objects)
			end,
			update_callback = function(self, c3, index, objects) --luacheck: no unused args
				self:get_children_by_id('index_role')[1].markup = index
				local tag = awful.screen.focused().tags[index]
				local clients = tag:clients()
				if #clients == 0 then
					self.fg = theme.colors.lightgray
				else
					self.fg = theme.colors.fg
				end

				if tag.is_urgent then
				else
					self:get_children_by_id("underline")[1].bg = nil
				end
				for _, x in pairs(awful.screen.focused().selected_tags) do
					if x.index == index then
						tag.is_urgent = false
						self.fg = theme.colors.fg
						self:get_children_by_id("underline")[1].bg = theme.colors.aqua
					break
				end
        end

			end,
		},
	}
end

return taglist
