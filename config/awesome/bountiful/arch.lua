local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local base = require("bountiful.base")

local function create_widget(_, args)
	local args = args or {}
	local refresh = args.refresh or 3600

	local theme = beautiful.get()

	local width, height = wibox.widget.textbox("  100"):get_preferred_size(awful.screen.primary)

	args.bg = theme.colors.dark.blue
	args.widget = wibox.widget {
		align  = "center",
		valign = "center",
		text = "n/a",
		forced_width = width,
		forced_height = height,
		widget = wibox.widget.textbox,
	}

	local widget = base.widget(args)
	widget.visible = false

	awesome.connect_signal("bountiful:focus:update", function(focus_mode)
		args.show_always = not focus_mode
	end)

	gears.timer {
		timeout = refresh,
		call_now = true,
		autostart = true,
		callback = function()
			awful.spawn.easy_async("checkupdates", function(stdout)
				local packages = 0
				for line in stdout:gmatch("([^\n]*)\n?") do
					if line == "" then
					else
						packages = packages + 1
					end
				end
				args.widget.text = "  " .. tostring(packages)
				if packages > 0 then
					widget.bg = theme.colors.orange
					widget.visible = true
				elseif packages > 20 then
					widget.bg = theme.colors.red
					widget.visible = true
				else
					widget.bg = theme.colors.green
					widget.visible = false or args.show_always 
				end
			end)
		end
	}

	return widget
end

return setmetatable({}, { __call = create_widget })
