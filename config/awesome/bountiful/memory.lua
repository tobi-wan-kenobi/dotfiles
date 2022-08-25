local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local base = require("bountiful.base")

local function create_widget(_, args)
	local theme = beautiful.get()

	args.width, args.height = wibox.widget.textbox("  99.0/99.0GiB"):get_preferred_size(awful.screen.primary)

  args.update = function(widget, text, bar, data)
			text.text = string.format("  %.1f/%.1f %s", data.used, data.total, data.unit)
			local value = data.used/data.total*100

			if value < 75 then
				bar.bg = theme.colors.green
				widget.visible = false or args.show_always
			elseif value < 85 then
				bar.bg = theme.colors.yellow
				widget.visible = true
			else
				bar.bg = theme.colors.red
				widget.visible = true
			end
  end

	local widget = base.widget(args)

	gears.timer {
		timeout = args.refresh or 5,
		call_now = true,
		autostart = true,
		callback = function()
			awful.spawn.easy_async("free --si -m", function(stdout)
				for line in stdout:gmatch("([^\n]*)\n?") do
					if line:match("Mem:") then
						local total, used = line:match("Mem:%s+(%d+)%s+(%d+)")
						total = tonumber(total)/1000
						used = tonumber(used)/1000
            widget:update({
              used = used, total = total, unit = "GiB"
            })
					end
				end
			end)
		end
	}

  return widget
end

return setmetatable({}, { __call = create_widget })
