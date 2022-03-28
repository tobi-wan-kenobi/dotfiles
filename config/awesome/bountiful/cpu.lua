local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local base = require("bountiful.base")

local function create_widget(_, args)
	local args = args or {}

	local theme = beautiful.get()
	local margin = base.margin(args)

	local width, height = wibox.widget.textbox("  800.0%"):get_preferred_size(awful.screen.primary)

	args.widget = wibox.widget {
		align  = "center",
		valign = "center",
		text = "n/a",
		forced_width = width,
		widget = wibox.widget.textbox,
	}

	local widget = base.widget(args)

	local bar = wibox.widget {
		max_value = 100,
		value = 50,
		forced_height = height,
		forced_width = width,
		shape = gears.shape.rounded_bar,
		border_width = 0,
		widget = wibox.widget.progressbar,
		id = "progressbar",
	}
	awesome.connect_signal("bountiful:focus:update", function(focus_mode)
		args.show_always = not focus_mode
	end)

	local full_widget = wibox.widget {
		layout = wibox.layout.stack,
		bar, widget,
		visible = false,
		set_value = function(self, value)
			args.widget.text = string.format("  %.1f%%", value)
			bar:set_value(value)

			if value < 50 then
				bar.color = theme.colors.green
				bar.background_color = theme.colors.dark.green
				self.visible = false or args.show_always 
			elseif value < 85 then
				bar.color = theme.colors.orange
				bar.background_color = theme.colors.dark.orange
				self.visible = true
			else
				bar.color = theme.colors.red
				bar.background_color = theme.colors.dark.red
				self.visible = true
			end
		end
	}

	awesome.connect_signal("bountiful:cpu:data", function(data)
		local idle = data:match("([%d.]+)\n?$")
		full_widget:set_value(100.0 - tonumber(idle))
	end)

	return full_widget
end

return setmetatable({}, { __call = create_widget })
