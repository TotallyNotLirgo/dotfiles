local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
local gears = require("gears")
local music_box = require("ui.bar.sound_control.music_box")
local clickable_container = require("modules.clickable-container")

-- Create a compstats widget
local volume = 0
local muted = false

local function wrap_icon(icon, color)
  return "<span foreground='" .. color .. "' font='FiraCode Nerd Font Mono 18' >" .. icon .. "</span> "
end

local function build_textbox()
  if muted or volume <= 0 then
    return wrap_icon("󰖁", Beautiful.selection) .. "<span foreground='" .. Beautiful.selection .. "'>" .. volume .. "%</span>"
  end
  return wrap_icon("󰕾", Beautiful.foreground) .. "<span foreground='" .. Beautiful.foreground .. "'>" .. volume .. "%</span>"
end

local widget = wibox.widget.textbox(build_textbox())
widget.font = Font12

local sound_widget = Helpers.bar_widget {
  {
    {
      widget = widget,
      align = "center",
    },
    widget = wibox.container.margin,
    left = dpi(10),
    right = dpi(10),
  },
  widget = clickable_container,
  shape = gears.shape.rounded_bar,
}

sound_widget:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      music_box.visible = not music_box.visible
      if music_box.visible then
        music_box.x = awful.screen.focused().geometry.x + awful.screen.focused().geometry.width - 400 - dpi(6)
        music_box.y = awful.screen.focused().geometry.y + beautiful.wibar_height + beautiful.useless_gap * 2
      end
    elseif button == 3 then
      awful.spawn("pamixer -t")
    elseif button == 4 then
      awful.spawn("pamixer -i 5")
    elseif button == 5 then
      awful.spawn("pamixer -d 5")
    end
  end
)

awesome.connect_signal(
  'signal::volume',
  function(v, m)
    volume = v or 0
    muted = m or false
    widget.markup = build_textbox()
  end
)
return sound_widget
