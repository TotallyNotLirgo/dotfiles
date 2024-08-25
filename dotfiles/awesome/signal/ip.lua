local awful = require("awful")
local update_interval = 1
local interface_script = [[
  sh -c "
    ip route | grep '^default' | grep -o 'dev [a-z0-9]*' | awk '{print $2}'
  "
]]
local function get_updown_script(interface)
  return [[
    sh -c "
      sar -n DEV 1 1 | grep ]] .. interface .. [[ | grep Average | grep -o ' [0-9]*\.[0-9]*' | sed -n 3,4p | tr -d '\n'
    "]]
end
local function get_ip_script(interface)
  return [[
    sh -c "
      ip addr show ]] .. interface .. [[ | grep 'inet ' | awk '{print $2}' | cut -d/ -f1
    "]]
end
awful.spawn.with_line_callback(interface_script, {
  stdout = function(interface)
    local updown_script = get_updown_script(interface)
    local ip_script = get_ip_script(interface)
    awful.widget.watch(updown_script, update_interval, function(_, stdout)
      local download = tonumber(stdout:match(' (.*) '))
      local upload = tonumber(stdout:match(' .* (.*)'))
      awesome.emit_signal("signal::network", download, upload)
    end)
    awful.widget.watch(ip_script, update_interval, function(_, stdout)
      local ip = stdout
      awesome.emit_signal("signal::ip", ip)
    end)
  end
})
