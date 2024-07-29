local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
require("theme.colors")
local gears = require("gears")
-- local markup = require("markup")

-- Create a compstats widget
local widget = wibox.widget.textbox('')
widget.font = 'FiraCode Nerd Font Mono 12'
local ram = 0
local cpu = 0
local disk = 0
local temp = 0

local function wrap_icon(icon)
  return "<span font='FiraCode Nerd Font Mono 18' >" .. icon .."</span> "
end

local function build_textbox()
  return wrap_icon(" 󰄨") .. ram .. "GB " .. wrap_icon("󰍛") .. cpu .. "% " .. wrap_icon("") .. disk .. "GB " -- .. "  " .. wrap_icon("󰈸") .. temp .. "°C"
end

local mycompstats = wibox.widget {
  {
    {
      {
        {
          widget = widget
        },
        widget = wibox.container.margin,
        right = dpi(10),
      },
      widget = wibox.container.background,
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar
}
mycompstats:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      awful.spawn("alacritty --class floater -e htop", {
        floating = true,
        ontop = true,
        placement = awful.placement.centered
      })
    end
  end
)
awesome.connect_signal(
  'signal::ram',
  function(used, _)
    ram = used
    widget.markup = build_textbox()
  end
)
awesome.connect_signal(
  'signal::cpu',
  function(used)
    cpu = used
    widget.markup = build_textbox()
  end
)
awesome.connect_signal(
  'signal::disk',
  function(used, _)
    disk = used
    widget.markup = build_textbox()
  end
)
awesome.connect_signal(
  'signal::temp',
  function(used)
    temp = used
    widget.markup = build_textbox()
  end
)
return mycompstats
