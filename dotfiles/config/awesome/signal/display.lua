local awful = require("awful")
local update_interval = 10
local script = [[
  sh -c "
    autorandr | grep current | cut -d ' ' -f1
  "]]

awful.widget.watch(script, update_interval, function(widget, stdout)
  awesome.emit_signal("signal::display", stdout)
end)
