local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local clickable_container = require("modules.clickable-container")
local function generate_textbox(icon, launcher, color)
  if color == nil then
    color = beautiful.foreground
  end
  return {
    {
      {
        widget = wibox.widget.textbox,
        markup = "<span foreground='" .. color .. "'>" .. icon .. "</span>",
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
      generate_textbox('', 'alacritty', Beautiful.red),
      generate_textbox('󰖟', 'brave', Beautiful.orange),
      generate_textbox('', 'pgadmin4', Beautiful.yellow),
      generate_textbox('󰍳', 'prismlauncher', Beautiful.green),
      generate_textbox('', 'spotify', Beautiful.green),
      generate_textbox('', 'signal-desktop', Beautiful.blue),
      generate_textbox('󰓓', 'steam', Beautiful.diff_text),
      generate_textbox('', 'thunar', Beautiful.purple),
      generate_textbox('', 'discord', Beautiful.dark_purple),
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
