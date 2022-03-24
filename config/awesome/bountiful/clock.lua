local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local function create_widget(_, args)
	local args = args or {}
	local refresh = args.refresh or 60
	local timezone = args.timezone
	local additional_zones = args.additional_timezones or {}
	local format = args.format or "%a %b %d"
	local margin = args.margin or {}
	local theme = beautiful.get() or {}

	if type(margin) == "number" then
		margin = {
			left = margin, right = margin, top = margin, bottom = margin
		}
	end

	local widget = wibox.widget {
		widget = wibox.container.background,
		bg = theme.colors.dark.blue,
		shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, height/2) end,
		{
			widget = wibox.container.margin,
			left = margin.left,
			right = margin.right,
			{
				widget = wibox.widget.textclock(format, refresh, timezone)
			}
		}
	}

	local popup_widgets = {
		layout = wibox.layout.fixed.vertical
	}
	for _, tz in ipairs(additional_zones) do
		table.insert(popup_widgets, wibox.container.margin(
			wibox.widget.textclock(format, refresh, tz),
			margin.left, margin.right, margin.top, margin.bottom
		))
	end

	if #popup_widgets > 1 then
		widget.popup = awful.popup {
			ontop = true,
			visible = false,
			shape = gears.shape.rounded_rect,
			border_width = 0,
			offset = 2,
			preferred_anchors = "middle",
			preferred_positions = "bottom",
			widget = wibox.widget {
				widget = wibox.container.background,
				bg = theme.colors.bglight,
				popup_widgets
			}
		}
		widget:connect_signal("mouse::enter", function()
			widget.popup.visible = true
			widget.popup:move_next_to(mouse.current_widget_geometry)
		end)
		widget:connect_signal("mouse::leave", function() widget.popup.visible = false end)
	end

	return widget
end

return setmetatable({}, { __call = create_widget })
