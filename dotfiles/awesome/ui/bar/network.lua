local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
require("theme.colors")
local gears = require("gears")
-- local markup = require("markup")

-- Create a ip widget
local widget = wibox.widget.textbox('')
widget.font = 'FiraCode Nerd Font Mono 12'
local down = "0B"
local up = "0B"
local ip = ""

local function wrap_icon(icon)
  return " <span font='FiraCode Nerd Font Mono 18' >" .. icon .."</span>"
end

local function build_textbox()
  return wrap_icon("") .. down .. wrap_icon("") .. up .. wrap_icon("") .. " " .. ip
end

local myip = wibox.widget {
  {
    {
      {
        {
          widget = widget
        },
        widget = wibox.container.margin,
        right = dpi(10)
      },
      widget = wibox.container.background,
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar
}
myip:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      awful.spawn("alacritty --class floater -e nmtui", {
        floating = true,
        ontop = true,
        placement = awful.placement.centered
      })
    end
  end
)
awesome.connect_signal(
  'signal::ip',
  function(_ip)
    ip = _ip
    widget.markup = build_textbox()
  end
)
awesome.connect_signal(
  'signal::network',
  function(_down, _up)
    up_int = _up * 1000
    down_int = _down * 1000
    up_b_mb_kb = up_int < 1024 and "B" or (up_int < 1048576 and "KiB" or "MiB")
    down_b_mb_kb = down_int < 1024 and "B" or (down_int < 1048576 and "KiB" or "MiB")
    up = up_int < 1024 and up_int or (up_int < 1048576 and math.floor(up_int / 1024 * 100) / 100 or math.floor(up_int / 1048576 * 100) / 100)
    down = down_int < 1024 and down_int or (down_int < 1048576 and math.floor(down_int / 1024 * 100) / 100 or math.floor(down_int / 1048576 * 100) / 100)
    up = up .. up_b_mb_kb
    down = down .. down_b_mb_kb
    widget.markup = build_textbox()
  end
)
return myip
