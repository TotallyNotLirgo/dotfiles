local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
require("theme.colors")
local gears = require("gears")
local music_box = require("ui.bar.music_box")

-- Create a compstats widget
local widget = wibox.widget.textbox('')
widget.font = 'FiraCode Nerd Font Mono 12'
local volume = 0
local muted = false

local function wrap_icon(icon, color)
  return "<span foreground='" .. color .. "' font='FiraCode Nerd Font Mono 18' >" .. icon .."</span> "
end

local function build_textbox()
  if muted or volume <= 0 then
    return wrap_icon("󰖁", "#aaaaaa") .. "<span foreground='#aaaaaa'>" .. volume .. "%</span>"
  end
  return wrap_icon("󰕾", "#ffffff") .. "<span foreground='#ffffff'>" .. volume .. "%</span>"
end

local sound_widget = wibox.widget {
  {
    {
      {
        {
          widget = widget
        },
        widget = wibox.container.margin,
      },
      widget = wibox.container.background,
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
}
sound_widget:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      awful.spawn("pavucontrol")
    elseif button == 3 then
      awful.spawn("pamixer -t")
    elseif button == 4 then
      awful.spawn("pamixer -i 5")
    elseif button == 5 then
      awful.spawn("pamixer -d 5")
    end
  end
)
sound_widget:connect_signal(
  "mouse::enter",
  function()
    music_box.visible = true
    music_box.x = awful.screen.focused().geometry.x + awful.screen.focused().geometry.width - 400
    music_box.y = awful.screen.focused().geometry.y + beautiful.wibar_height
  end
)
sound_widget:connect_signal(
  "mouse::leave",
  function()
    local w = mouse.current_wibox
    if w and w.x == 0 then
      music_box.visible = false
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
