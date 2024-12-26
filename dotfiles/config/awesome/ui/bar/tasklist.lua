local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi
local clickable_container = require("modules.clickable-container")


local function get_tasklist(s)
  local centered_tasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.minimizedcurrenttags,
    buttons = {
      awful.button({}, 1, function(c)
        c:activate{context = "tasklist", action = "toggle_minimization"}
      end)
    },
    layout = {
      spacing = Beautiful.useless_gap,
      layout = wibox.layout.flex.horizontal,
    },
    widget_template = {
      {
        {
          {
            {
              id = 'icon_role',
              image = beautiful.awesome_icon,
              widget = wibox.widget.imagebox,
              resize = true,
            },
            margins = dpi(5),
            widget = wibox.container.margin,
          },
          forced_height = 30,
          forced_width = 30,
          shape = gears.shape.rounded_rect,
          widget = clickable_container
        },
        margins = Beautiful.useless_gap,
        widget = wibox.container.margin,
      },
      widget = wibox.container.background,
    }
  }

  return centered_tasklist
end
return get_tasklist
