local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
require("theme.colors")
local gears = require("gears")
local naughty = require("naughty")
-- local markup = require("markup")

-- Create a compstats widget
local widget = wibox.widget.textbox('')
widget.font = 'FiraCode Nerd Font Mono 12'
local charge = 100
local status = ""
local notification_up = false

local function wrap_icon(icon)
  return " <span font='FiraCode Nerd Font Mono 18' >" .. icon .."</span>"
end

local function build_textbox()
  local icon = ""
  if status == "Charging" then
    icon = "󰂄"
    notification_up = false
  else
    if charge < 10 then
      icon = "󰂎"
    elseif charge < 20 then
      icon = "󰁺"
      if not notification_up then
        notification_up = true
        naughty.notify({title="Battery Low", text="Battery is low, please plug in your charger"})
      end
    elseif charge < 30 then
      icon = "󰁻"
    elseif charge < 40 then
      icon = "󰁼"
    elseif charge < 50 then
      icon = "󰁽"
    elseif charge < 60 then
      icon = "󰁾"
    elseif charge < 70 then
      icon = "󰁿"
    elseif charge < 80 then
      icon = "󰂀"
    elseif charge < 90 then
      icon = "󰂁"
    elseif charge < 100 then
      icon = "󰂂"
    else
      icon = "󰁹"
    end
  end
  return wrap_icon(icon)  .. charge .. "%"
end

local battery = wibox.widget {
  {
    {
        {
          widget = widget
        },
        widget = wibox.container.margin,
        right = dpi(5),
      },
      widget = wibox.container.background,
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar
}
awesome.connect_signal(
  'signal::battery',
  function(c, s)
    charge = c
    status = s
    widget.markup = build_textbox()
  end
)
return battery
