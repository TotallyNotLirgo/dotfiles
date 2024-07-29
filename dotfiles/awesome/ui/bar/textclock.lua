local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
require("theme.colors")
local gears = require("gears")
clickable_container = require("modules.clickable-container")
local cal_toggle = require("ui.bar.calendar")
local awful = require("awful")
-- local markup = require("markup")

-- Create a textclock widget
mytextclock = wibox.widget {
  {
    {
      {
        widget = wibox.widget.textclock('<span font="FiraCode Nerd Font Mono Bold 12">%H:%M:%S</span>', 1),
        align = "center",
      },
      widget = wibox.container.margin,
      right = dpi(10),
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
}

mytextclock:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then cal_toggle(awful.screen.focused()) end
end)

return mytextclock
