-- Provides:
-- signal::temperature
--      temperature (integer - in Celcius)
local awful = require("awful")

local update_interval = 15
local temp_script = [[
  sh -c "
  nvidia-smi -q -d temperature | grep 'GPU Current' | grep -o '[0-9\.]*'
  "]]

-- Periodically get temperature info
awful.widget.watch(temp_script, update_interval, function(widget, stdout)
    -- awesome.emit_signal("signal::temp", tonumber(stdout))
end)
