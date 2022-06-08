
local errors = {}

function startup_errors()
	if awesome.startup_errors then
	end
end

function runtime_errors()
	do
		local in_error = false
		awesome.connect_signal("debug::error", function (err)
			-- Make sure we don't go into an endless error loop
			if in_error then return end
			in_error = true

			in_error = false
		end)
	end
end

function errors.init()
	startup_errors()
	runtime_errors()
end

return errors
