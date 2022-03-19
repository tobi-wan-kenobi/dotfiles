local naughty = require("naughty")

local errors = {}

function startup_errors()
	if awesome.startup_errors then
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "startup error",
			text = awesome.startup_errors
		})
	end
end

function runtime_errors()
	do
		local in_error = false
		awesome.connect_signal("debug::error", function (err)
			-- Make sure we don't go into an endless error loop
			if in_error then return end
			in_error = true

			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "runtime error",
				text = tostring(err)
			})
			in_error = false
		end)
	end
end

function errors.init()
	startup_errors()
	runtime_errors()
end

return errors
