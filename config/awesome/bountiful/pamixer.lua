local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local base = require("bountiful.base")

local function volume_string(volume, icon)
	return icon .. "  " .. volume .. "%"
end

local pid = awful.spawn.with_line_callback("pactl subscribe", {
	stdout = function(line)
		if line:match ".*client.*" then return end
		awesome.emit_signal("bountiful:pamixer:update")
	end
})

awesome.connect_signal("exit", function()
	awesome.kill(pid, awesome.unix_signal.SIGTERM)
end)

local sink_mixer = {
	header = "Sinks",
	get = "pamixer --get-volume",
	get_mute = "pamixer --get-mute",
	list = "pamixer --list-sinks",
	toggle_mute = "pamixer --toggle-mute",
	increase = "pamixer --increase 2",
	decrease = "pamixer --decrease 2",
	get_default = "pactl info | grep -i 'default sink'",
	set_default = "pactl set-default-sink ",
	not_muted = "",
	muted = "",
}
local source_mixer = {
	header = "Sources",
	get = "pamixer --get-volume --default-source",
	get_mute = "pamixer --get-mute --default-source",
	list = "pamixer --list-sources",
	toggle_mute = "pamixer --toggle-mute --default-source",
	increase = "pamixer --default-source --increase 2",
	decrease = "pamixer --default-source --decrease 2",
	get_default = "pactl info | grep -i 'default source'",
	set_default = "pactl set-default-source ",
	not_muted = "",
	muted = "",
}

local function parse_device_list(data)
	local devices = {}
	for line in data:gmatch("([^\n]*)\n?") do
		local fields = {}
		local id, name = line:match("\"([^\"]+)\"%s+\"([^\"]+)\"")

		if id then
			devices[id] = {
				name = name,
				default = false,
			}
		end
	end

	return devices
end

local function mark_default_device(devices, data)
	local def = data:match(": (%S+)")

	devices[def].default = true

	return devices
end

local function create_device_widgets(popup, mixer, devices, size, margin, colors)
	local widgets = {
		layout = wibox.layout.fixed.vertical,
		wibox.widget {
			{
				markup = "<big><b>" .. mixer.header .. "</b></big>",
				widget = wibox.widget.textbox
			},
			left = margin.left,
			right = margin.right,
			top = margin.top,
			bottom = margin.bottom,
			widget = wibox.container.margin
		}
	}

	local checkboxes = {}
	for id, dev in pairs(devices) do
		local checkbox = wibox.widget {
			widget = wibox.widget.checkbox,
			checked = dev.default,
			forced_height = size,
			forced_width = size,
			color = beautiful.fg_normal,
			paddings = 2,
			shape = gears.shape.circle,
		}
		table.insert(checkboxes, checkbox)
		local label = wibox.widget {
			text = "  " .. dev.name,
			widget = wibox.widget.textbox,
		}
		local widget = wibox.widget {
			{
				widget = wibox.layout.fixed.horizontal,
				checkbox, label
			},
			left = margin.left,
			right = margin.right,
			top = margin.top,
			bottom = margin.bottom,
			widget = wibox.container.margin
		}
		widget:connect_signal("mouse::enter", function()
			checkbox.color = colors.fglight
			label.markup = "<span foreground='" .. colors.fglight ..  "'>" .. label.text .. "</span>"
		end)
		widget:connect_signal("mouse::leave", function()
			checkbox.color = beautiful.fg_normal
			label.markup = label.text
		end)
		widget:buttons(gears.table.join(
			awful.button({}, 1, function()
				for _, c in ipairs(checkboxes) do
					c.checked = false
				end
				awful.spawn.easy_async(mixer.set_default .. id, function()
					checkbox.checked = true
				end)
			end)
		))
		table.insert(widgets, widget)
	end

	return widgets
end

local function create_widget(_, args)
	local args = args or {}
	local source = args.source or false
	local theme = beautiful.get() or {}
	local margin = base.margin(args)

	local mixer = source and source_mixer or sink_mixer
	mixer.color = source and theme.colors.dark.aqua or theme.colors.dark.green
	mixer.color_light = source and theme.colors.aqua or theme.colors.green

	args.widget = wibox.widget.textbox("n/a")

	local width, height = wibox.widget.textbox(volume_string("muted", mixer.not_muted)):get_preferred_size(awful.screen.primary)
	args.widget.forced_width = width
	args.widget.align = "center"

	local widget = base.widget(args)

	local bar = wibox.widget {
		max_value = 100,
		forced_height = height,
		forced_width = args.widget.forced_width,
		shape = gears.shape.rounded_bar,
		border_width = 0,
		widget = wibox.widget.progressbar,
	}

	local full_widget = wibox.widget {
		layout = wibox.layout.stack,
		bar, widget
	}

	awesome.connect_signal("bountiful:pamixer:update", function()
		local volume = "n/a"
		awful.spawn.easy_async(mixer.get, function(stdout, stderr, reason, code)
			volume = stdout:gsub("^%s*(.-)%s*$", "%1")
			args.widget.text = volume_string(volume, mixer.not_muted)
			local color = tonumber(volume) > 100 and theme.colors.dark.red or mixer.color
			awful.spawn.easy_async(mixer.get_mute, function(stdout, stderr, reason, code)
				if stdout:match "^%s*(.-)%s*$" == "true" then
					color = theme.colors.dark.orange
					args.widget.text = volume_string(volume, mixer.muted)
					volume = 0
				end
				bar.color = tonumber(volume) > 100 and theme.colors.red or mixer.color_light
				bar.background_color = color
				bar:set_value(tonumber(volume))
			end)
		end)
	end)

	local popup = awful.popup {
		ontop = true,
		visible = false,
		shape = gears.shape.rounded_rect,
		border_width = 0,
		offset = 2,
		maximum_width = 400,
		preferred_anchors = "middle",
		preferred_positions = "bottom",
		widget = wibox.widget {
			widget = wibox.container.background,
			bg = theme.colors.bglight
		}
	}

	widget:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.spawn(mixer.toggle_mute)
		end),
		awful.button({}, 3, function()
			if popup.visible then
				popup.visible = false
			else
				awful.spawn.easy_async(mixer.list, function(stdout)
					local devices = parse_device_list(stdout)
					awful.spawn.easy_async_with_shell(mixer.get_default, function(stdout)
						devices = mark_default_device(devices, stdout)

						popup.widget = wibox.widget {
							widget = wibox.container.background,
							bg = theme.colors.bglight,
							create_device_widgets(popup, mixer, devices, height, margin, theme.colors)
						}
						popup.visible = true
						popup:move_next_to(mouse.current_widget_geometry)
					end)
				end)
			end
		end),
		awful.button({}, 4, function()
			awful.spawn(mixer.increase)
		end),
		awful.button({}, 5, function()
			awful.spawn(mixer.decrease)
		end)
	))
	-- initial update
	awesome.emit_signal("bountiful:pamixer:update")

	return full_widget
end

return setmetatable({}, { __call = create_widget })

