local awful = require("awful")
local update_interval = 1
local updown_script = [[
  sh -c "
    sar -n DEV 1 1 | grep enp4s0 | grep Average | grep -o ' [0-9]*\.[0-9]*' | sed -n 3,4p | tr -d '\n'
  "]]
local ip_script = [[
  sh -c "
    ip addr show enp4s0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1
  "]]

awful.widget.watch(updown_script, update_interval, function(widget, stdout)
  local download = tonumber(stdout:match(' (.*) '))
  local upload = tonumber(stdout:match(' .* (.*)'))
  awesome.emit_signal("signal::network", download, upload)
end)

awful.widget.watch(ip_script, update_interval, function(widget, stdout)
  local ip = stdout
  awesome.emit_signal("signal::ip", ip)
end)
