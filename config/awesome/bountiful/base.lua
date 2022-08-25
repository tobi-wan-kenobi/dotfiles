local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local base = {}

function base.widget(args)
	local theme = beautiful.get()

  args.show_always = args.show_always or false

  if args.show_always == false then
    awesome.connect_signal('bountiful:focus:update', function(focus_mode)
      args.show_always = not focus_mode
    end)
  end

  local widget = args.widget

  if widget == nil then
    widget = {
      id = 'text',
      align  = 'center',
      valign = 'center',
      text = 'n/a',
      forced_width = width,
      widget = wibox.widget.textbox,
    }
  end

  local widget = wibox.widget {
		forced_width = args.width,
    layout = wibox.layout.fixed.vertical,
    widget,
    {
      id = 'bar',
      widget = wibox.container.background,
      shape = gears.shape.rounded_rect,
      forced_height = 3,
      bg = theme.colors.aqua,
      {
        left = 1,
        right = 1,
        widget = wibox.container.margin
      },
    }
  }
	return wibox.widget {
    visible = args.show_always,
    widget = wibox.container.margin,
    left = args.margin or 5,
    right = args.margin or 5,
    widget,
    update = function(self, data)
      local bar = widget:get_children_by_id('bar')[1]
      local text = widget:get_children_by_id('text')[1]

      args.update(self, text, bar, data)
    end,
  }
end

return base
