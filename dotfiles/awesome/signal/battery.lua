local awful = require("awful")
local update_interval = 10
local charge_script = [[
  sh -c "
    cat /sys/class/power_supply/BAT1/{capacity,status} | tr '\n' '@'
  "]]

awful.widget.watch(charge_script, update_interval, function(widget, stdout)
  local capacity = tonumber(stdout:match('(.*)@.*@'))
  local status = stdout:match('.*@(.*)@')
  awesome.emit_signal("signal::battery", capacity, status)
end)
