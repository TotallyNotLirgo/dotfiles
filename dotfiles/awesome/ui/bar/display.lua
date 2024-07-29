local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
require("theme.colors")
local gears = require("gears")
-- local markup = require("markup")

local widget = wibox.widget.textbox('')
local type = "duplicated"
widget.font = 'FiraCode Nerd Font Mono 12'

local function wrap_icon(icon)
  return "<span font='FiraCode Nerd Font Mono 24' >" .. icon .."</span>"
end

local function build_textbox()
  if type == "extended" then
    return wrap_icon("󰍺")
  elseif type == "duplicated" then
    return wrap_icon("󰹑")
  elseif type == "single" then
    return wrap_icon("󰍹")
  end
end

local display_widget = wibox.widget {
  {
    {
      {
        {
          widget = widget
        },
        widget = wibox.container.margin,
        left = dpi(10),
        right = dpi(10),
      },
      widget = wibox.container.background,
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar
}
display_widget:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      awful.spawn("arandr --class floater", {
        floating = true,
        ontop = true,
        placement = awful.placement.centered
      })
    elseif button == 3 then
      if type == "duplicated" then
        type = "extended"
        widget.markup = build_textbox()
      elseif type == "extended" then
        type = "duplicated"
        widget.markup = build_textbox()
      end
    end
  end
)
widget.markup = build_textbox()
return display_widget
