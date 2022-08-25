local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local base = require("bountiful.base")

local function create_widget(_, args)
	local theme = beautiful.get()

	args.width, args.height = wibox.widget.textbox("  100"):get_preferred_size(awful.screen.primary)

  args.update = function(widget, text, bar, packages)
      text.text = "  " .. tostring(packages)
      if packages > 20 then
        bar.bg = theme.colors.red
        widget.visible = true
      elseif packages > 0 then
        bar.bg = theme.colors.yellow
        widget.visible = true
      else
        bar.bg = theme.colors.green
        widget.visible = args.show_always
      end
  end

	local widget = base.widget(args)

	gears.timer {
		timeout = args.refresh or 1800,
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
        widget:update(packages)
			end)
		end
  }

  return widget
end

return setmetatable({}, { __call = create_widget })
