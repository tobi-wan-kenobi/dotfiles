local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local base = require("bountiful.base")

local function create_widget(_, args)
	local args = args or {}

	local theme = beautiful.get()
	local margin = base.margin(args)

	local width, height = wibox.widget.textbox("A"):get_preferred_size(awful.screen.primary)
	args.widget = wibox.widget {
		widget = wibox.widget.checkbox,
		checked = true,
		color = beautiful.fg_normal,
		paddings = 2,
		forced_width = height,
		forced_height = height,
		shape = gears.shape.rect,
		buttons = gears.table.join(
			awful.button({}, 1, function()
				args.widget.checked = not args.widget.checked
				awesome.emit_signal("bountiful:focus:update", args.widget.checked)
			end)
		)
	}

	local widget = base.widget(args)

	return wibox.widget {
		widget = wibox.container.place,
		widget
	}
end

return setmetatable({}, { __call = create_widget })
