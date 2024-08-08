local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local dpi = require("beautiful.xresources").apply_dpi
require("theme.colors")
local gears = require("gears")
local clickable_container = require("modules.clickable-container")
-- local markup = require("markup")
--
      -- spacing = dpi(10),
      -- layout = wibox.layout.fixed.horizontal,

local popupWidget = wibox.widget {
  {
    {
      {
        { image = "/home/emilia/.local/share/icons/previous.svg", forced_height = 40, forced_width = 40, widget = wibox.widget.imagebox, },
        shape = gears.shape.rounded_bar,
        widget = clickable_container,
        buttons = gears.table.join( awful.button( {}, 1, nil, function() awful.spawn("brave") end)),
      },
      {
        { image = "/home/emilia/.local/share/icons/play.svg", forced_height = 40, forced_width = 40, widget = wibox.widget.imagebox, },
        shape = gears.shape.rounded_bar,
        widget = clickable_container,
        buttons = gears.table.join( awful.button( {}, 1, nil, function() awful.spawn("alacritty") end)),
      },
      {
        { image = "/home/emilia/.local/share/icons/next.svg", forced_height = 40, forced_width = 40, widget = wibox.widget.imagebox, },
        shape = gears.shape.rounded_bar,
        widget = clickable_container,
        buttons = gears.table.join( awful.button( {}, 1, nil, function() awful.spawn("steam") end)),
      },
      layout = wibox.layout.flex.horizontal,
      spacing = dpi(5),
    },
    widget = wibox.container.margin,
    margins = dpi(2),
  },
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
}
return popupWidget
