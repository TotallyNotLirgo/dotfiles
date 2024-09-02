local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
local gears = require("gears")
local clickable_container = require("modules.clickable-container")

local type = "duplicated"
local display_mode = "single"

local function wrap_icon(icon)
  return f"<span font='{Font24}' >" .. icon .."</span>"
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

local widget = wibox.widget.textbox(wrap_icon('󰍺'))

local display_widget = Helpers.bar_widget {
  {
    widget,
    margins = dpi(6),
    widget = wibox.container.margin,
  },
  widget = clickable_container,
  shape = gears.shape.circle
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
        awful.spawn("autorandr --load work")
        display_mode = "work\n"
      elseif type == "extended" then
        type = "duplicated"
        widget.markup = build_textbox()
        awful.spawn("autorandr --load single")
        display_mode = "single\n"
      end
    end
  end
)

awesome.connect_signal(
  'signal::display',
  function(_display_mode)
    if _display_mode == display_mode then
      return
    end
    display_mode = _display_mode
    if display_mode == "work\n" then
      type = "extended"
    elseif display_mode == "single\n" then
      type = "duplicated"
    end
    widget.markup = build_textbox()
  end
)

return display_widget
