local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local function create_widget(_, args)
	args = args or {}
	refresh = args.refresh or 60
	timezone = args.timezone
	additional_zones = args.additional_timezones or {}
	format = args.format or "%a %b %d"
	margin = args.margin or 10
	local widget = wibox.container.margin(wibox.widget.textclock(format, refresh, timezone), margin, margin)

	local popup_widgets = {
		layout = wibox.layout.fixed.vertical
	}
	for _, tz in ipairs(additional_zones) do
		table.insert(popup_widgets, wibox.container.margin(wibox.widget.textclock(format, refresh, tz), margin, margin, margin, margin))
	end

	if #popup_widgets > 1 then
		widget.popup = awful.popup {
			ontop = true,
			visible = false,
			shape = gears.shape.rounded_rect,
			border_width = 2,
			border_color = beautiful.fg_normal,
			offset = 2,
			preferred_anchors = "middle",
			preferred_positions = "bottom",
			widget = popup_widgets
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

