local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local clickable_container = require("modules.clickable-container")
local function generate_textbox(icon, launcher)
  return {
    {
      {
        widget = wibox.widget.textbox,
        markup = icon,
        font = Font .. " 32",
        forced_height = 32,
      },
      widget = wibox.container.margin,
      margins = dpi(10),
    },
    shape = gears.shape.circle,
    widget = clickable_container,
    buttons = gears.table.join(awful.button({}, 1, nil, function() awful.spawn(launcher) end)),
  }
end

local popupWidget = wibox.widget {
  {
    {
      generate_textbox('󰖟', 'brave'),
      generate_textbox('', 'alacritty'),
      generate_textbox('󰓓', 'steam'),
      generate_textbox('󰍳', 'prismlauncher'),
      generate_textbox('', 'spotify'),
      generate_textbox('', 'thunar'),
      generate_textbox('', 'signal-desktop'),
      generate_textbox('', 'discord'),
      generate_textbox('', 'pgadmin4'),
      layout = wibox.layout.flex.horizontal,
    },
    widget = wibox.container.margin,
    left = dpi(4),
    right = dpi(4),
  },
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
}
return popupWidget
