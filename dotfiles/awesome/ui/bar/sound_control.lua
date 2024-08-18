local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
require("theme.colors")
local gears = require("gears")
local music_box = require("ui.bar.music_box")

-- Create a compstats widget
local volume = 0
local muted = false

local function wrap_icon(icon, color)
  return "<span foreground='" .. color .. "' font='FiraCode Nerd Font Mono 18' >" .. icon .. "</span> "
end

local function build_textbox()
  if muted or volume <= 0 then
    return wrap_icon("󰖁", "#aaaaaa") .. "<span foreground='#aaaaaa'>" .. volume .. "%</span>"
  end
  return wrap_icon("󰕾", "#ffffff") .. "<span foreground='#ffffff'>" .. volume .. "%</span>"
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
    if w and w.x == awful.screen.focused().geometry.x then
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
