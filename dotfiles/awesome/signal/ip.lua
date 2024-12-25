local awful = require("awful")
local update_interval = 1
local updown_script = [[
  sh -c "
    INTERFACE=$(ip route | grep '^default' | grep -o 'dev [a-z0-9]*' | awk '{print $2}');
    sar -n DEV 1 1 | grep $INTERFACE | grep Average | grep -o ' [0-9]*\.[0-9]*' | sed -n 3,4p | tr -d '\n'
"]]
local ip_script = [[
  sh -c "
    INTERFACE=$(ip route | grep '^default' | grep -o 'dev [a-z0-9]*' | awk '{print $2}');
    ip addr show $INTERFACE | grep 'inet ' | awk '{print $2}' | cut -d/ -f1
"]]

awful.widget.watch(updown_script, update_interval, function(_, stdout)
  local download = tonumber(stdout:match(' (.*) '))
  local upload = tonumber(stdout:match(' .* (.*)'))
  awesome.emit_signal("signal::network", download, upload)
end)
awful.widget.watch(ip_script, update_interval, function(_, stdout)
  local ip = stdout
  awesome.emit_signal("signal::ip", ip)
end)
