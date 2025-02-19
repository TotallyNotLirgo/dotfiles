local wibox = require("wibox")
local gears = require("gears")
local clickable_container = require("modules.clickable-container")
local cal_toggle = require("ui.bar.textclock.calendar")
local awful = require("awful")
---@diagnostic disable-next-line: unused-local
local font = Font .. " Bold 12"

-- Create a textclock widget
local textclock = Helpers.bar_widget {
      {
        {
          widget = wibox.widget.textclock('<span font="' .. font .. '">%a %d-%m-%Y %H:%M:%S</span>', 1),
          align = "center",
        },
        widget = wibox.container.margin,
        left = Beautiful.useless_gap * 2,
        right = Beautiful.useless_gap * 2,
      },
      widget = clickable_container,
      shape = gears.shape.rounded_bar,
}

textclock:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then cal_toggle(awful.screen.focused()) end
end)

return textclock
