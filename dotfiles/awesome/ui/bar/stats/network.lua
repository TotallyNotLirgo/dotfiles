local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local header = wibox.widget.textbox("<span weight='bold'>Network:</span>")
local ip_widget = wibox.widget.textbox('127.0.0.1')
local up_widget = wibox.widget.textbox('0B')
local down_widget = wibox.widget.textbox('0B')
header.font = Font12
ip_widget.font = Font12
up_widget.font = Font12
down_widget.font = Font12
local down = "0B"
local up = "0B"
local ip = ""

local function wrap_icon(icon, color)
  if color == nil then
    color = Beautiful.foreground
  end
  return "<span font='FiraCode Nerd Font Mono 18' foreground='" .. color .. "'>" .. icon .. "</span>"
end

local function build_widget()
  ip_widget.markup = wrap_icon("", Beautiful.blue) .. " " .. ip
  up_widget.markup = wrap_icon("", Beautiful.blue) .. " " .. up
  down_widget.markup = wrap_icon("", Beautiful.blue) .. " " .. down
end

local myip = wibox.widget {
  {
    {
      { widget = header, forced_height = dpi(30) },
      { widget = ip_widget, forced_height = dpi(30) },
      { widget = up_widget, forced_height = dpi(30) },
      { widget = down_widget, forced_height = dpi(30) },
      layout = wibox.layout.fixed.vertical,
      spacing = Beautiful.useless_gap,
   },
    widget = wibox.container.margin,
    left = dpi(8),
    right = dpi(8),
    top = dpi(4),
    bottom = dpi(4),
  },
  widget = wibox.container.background,
  forced_width = dpi(200),
}
awesome.connect_signal(
  'signal::ip',
  function(_ip)
    ip = _ip
    build_widget()
  end
)
awesome.connect_signal(
  'signal::network',
  function(_down, _up)
    if _down == nil or _up == nil then
      return
    end
    local up_int = _up * 1000
    local down_int = _down * 1000
    local up_b_mb_kb = up_int < 1024 and "B" or (up_int < 1048576 and "KiB" or "MiB")
    local down_b_mb_kb = down_int < 1024 and "B" or (down_int < 1048576 and "KiB" or "MiB")
    up = tostring(up_int < 1024 and up_int or (up_int < 1048576 and math.floor(up_int / 1024 * 100) / 100 or math.floor(up_int / 1048576 * 100) / 100))
    down = tostring(down_int < 1024 and down_int or (down_int < 1048576 and math.floor(down_int / 1024 * 100) / 100 or math.floor(down_int / 1048576 * 100) / 100))
    up = up .. up_b_mb_kb
    down = down .. down_b_mb_kb
    build_widget()
  end
)
return myip
