local awful = require("awful")

local update_interval = 1
local ram_script = [[
  sh -c "
  free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'
  "]]

-- Periodically get ram info
awful.widget.watch(ram_script, update_interval, function(_, stdout)
  local available = stdout:match('(.*)@@')
  local total = stdout:match('@@(.*)@')
  local used = tonumber(total) - tonumber(available)
  used = tonumber(string.format("%.2f", used / 1024)) or 0
  awesome.emit_signal("signal::ram", used, total)
end)
