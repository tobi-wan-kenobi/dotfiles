local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local base = require("bountiful.base")


local function create_widget(_, args)
	local args = args or {}
	local refresh = args.refresh or 10

	local theme = beautiful.get()
	local margin = base.margin(args)

	local width, height = wibox.widget.textbox(" 99.0/99.0GiB"):get_preferred_size(awful.screen.primary)

	args.widget = wibox.widget {
			align  = "center",
			valign = "center",
			text = "this is a text",
			forced_width = width,
			widget = wibox.widget.textbox,
			id = "memusage",
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

	local graph = wibox.widget {
		max_value = 100,
		widget = wibox.widget.graph,
		id = "graph",
		forced_width = width/2,
		background_color = theme.colors.bglight
	}

	local full_widget = wibox.widget {
		layout = wibox.layout.fixed.horizontal,
		{
			widget = wibox.container.margin,
			right = margin.right,
			graph
		},
		{
			layout = wibox.layout.stack,
			bar, widget,
		},
		set_values = function(self, used, total, unit)
			args.widget.text = string.format("%.2f/%.2f %s", used, total, unit)
			local value = used/total*100
			bar:set_value(value)
			graph:add_value(value)

			if value < 75 then
				bar.color = theme.colors.green
				graph.color = theme.colors.green
				bar.background_color = theme.colors.dark.green
			elseif value < 85 then
				bar.color = theme.colors.orange
				graph.color = theme.colors.orange
				bar.background_color = theme.colors.dark.orange
			else
				bar.color = theme.colors.red
				graph.color = theme.colors.red
				bar.background_color = theme.colors.dark.red
			end
		end
	}

	gears.timer {
		timeout = 5,
		call_now = true,
		autostart = true,
		callback = function()
			awful.spawn.easy_async("free --si -m", function(stdout)
				for line in stdout:gmatch("([^\n]*)\n?") do
					if line:match("Mem:") then
						local total, used = line:match("Mem:%s+(%d+)%s+(%d+)")
						total = tonumber(total)/1000
						used = tonumber(used)/1000
						full_widget:set_values(used, total, "GiB")
					end
				end
			end)
		end
	}

	return full_widget
end

return setmetatable({}, { __call = create_widget })
