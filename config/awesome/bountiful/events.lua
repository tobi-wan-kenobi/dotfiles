local awful = require("awful")

local events = {}

function monitor_pulseaudio()
	local pid = awful.spawn.with_line_callback("pactl subscribe", {
		stdout = function(line)
			if line:match ".*client.*" then return end
			awesome.emit_signal("bountiful:pulseaudio:update")
		end
	})
	awesome.connect_signal("exit", function()
		awesome.kill(pid, awesome.unix_signal.SIGTERM)
	end)
	-- initial update
	awesome.emit_signal("bountiful:pulseaudio:update")
end

function monitor_cpu()
	local pid = awful.spawn.with_line_callback("mpstat -P all 1", {
		stdout = function(line)
			if not line:match ".*all.*" then return end
			awesome.emit_signal("bountiful:cpu:data", line)
		end
	})

	awesome.connect_signal("exit", function()
		awesome.kill(pid, awesome.unix_signal.SIGTERM)
	end)
end

function events:init(args)
	args = args or {}
	if args.pulseaudio then
		monitor_pulseaudio()
	end
	if args.cpu then
		monitor_cpu()
	end
end

return events
