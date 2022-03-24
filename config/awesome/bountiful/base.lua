local wibox = require("wibox")
local gears = require("gears")

local base = {}

function base.margin(args)
	local margin = args.margin or {}
	if type(margin) == "number" then
		margin = {
			left = margin, right = margin, top = margin, bottom = margin
		}
	end
	return margin
end

function base.widget(args)
	local margin = base.margin(args)
	local widget = wibox.widget {
		widget = wibox.container.background,
		bg = args.bg,
		shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, height/2) end,
		{
			widget = wibox.container.margin,
			left = margin.left,
			right = margin.right,
			{
				widget = args.widget
			}
		}
	}
	return widget
end

return base
