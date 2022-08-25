local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local base = require("bountiful.base")

local function create_widget(_, args)
	local theme = beautiful.get()

	args.width, args.height = wibox.widget.textbox("  800.0%"):get_preferred_size(awful.screen.primary)

  args.update = function(widget, text, bar, value)
    text.text = string.format("  %.1f%%", value)

    if value < 50 then
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

	awesome.connect_signal("bountiful:cpu:data", function(data)
		local idle = data:match("([%d.]+)\n?$")
    widget:update(100.0 - tonumber(idle))
	end)

  return widget
end

return setmetatable({}, { __call = create_widget })
