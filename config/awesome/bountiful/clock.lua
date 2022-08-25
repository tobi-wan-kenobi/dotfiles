local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local base = require('bountiful.base')

local function create_widget(_, args)
	local theme = beautiful.get()
	local refresh = args.refresh or 60
	local format = args.format or '%a %b %d'

  timezones = args.timezones

	args.widget = wibox.widget.textclock(format, refresh, timezones[1])
  args.widget:connect_signal('button::press', function(widget, lx, ly, button)
    if button == 1 then
      table.insert(timezones, #timezones+1, timezones[1])
      table.remove(timezones, 1)
    elseif button == 3 then
      table.insert(timezones, 1, timezones[#timezones])
      table.remove(timezones, #timezones)
    end
      args.widget.timezone = timezones[1]
  end)

	local widget = base.widget(args)

  return widget
end

return setmetatable({}, { __call = create_widget })
