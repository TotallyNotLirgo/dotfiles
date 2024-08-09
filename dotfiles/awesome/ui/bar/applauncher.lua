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
local function generate_textbox(icon, launcher)
  return {
    {
      {
        widget = wibox.widget.textbox,
        markup = icon,
        font = 'firacode nerd font mono 32',
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
    left = dpi(10),
    right = dpi(10),
  },
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
}
return popupWidget
