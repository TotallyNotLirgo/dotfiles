local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
require("theme.colors")
local gears = require("gears")
clickable_container = require("modules.clickable-container")
-- local markup = require("markup")
--
local cancelButton = wibox.widget({
  {
    awful.widget.button(
      {
        image = "/home/emilia/.local/share/icons/close.svg",
        resize = true,
        widget = wibox.widget.imagebox,
      }
    ),
    widget = wibox.container.margin,
    margins = dpi(8),
  },
  widget = clickable_container,
  shape = gears.shape.rounded_bar,
})
local shutdownButton = wibox.widget({
  {
    {
      markup = "Shutdown",
      widget = wibox.widget.textbox,
      align = "center",
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
})
local rebootButton = wibox.widget({
  {
    {
      markup = "Reboot",
      widget = wibox.widget.textbox,
      align = "center",
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
})
local logoutButton = wibox.widget({
  {
    {
      markup = "Logout",
      widget = wibox.widget.textbox,
      align = "center",
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
})


local popupWidget = wibox.widget {
  {
    nil,
    {
      {
        wibox.widget.textbox("<b>Choose an option:</b>"),
        nil,
        cancelButton,
        layout  = wibox.layout.align.horizontal
      },
      margins = dpi(16),
      widget = wibox.container.margin
    },
    {
      {
        {
          logoutButton,
          widget = wibox.container.margin,
          right = dpi(15),
        },
        {
          rebootButton,
          widget = wibox.container.margin,
        },
        {
          shutdownButton,
          widget = wibox.container.margin,
          left = dpi(15),
        },
        layout = wibox.layout.flex.horizontal,
      },
      margins = dpi(16),
      widget = wibox.container.margin
    },
    layout = wibox.layout.flex.vertical,
  },
  resize = true,
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
  forced_height = 150,
  forced_width = 400,
}

local popup = awful.popup {
  ontop = true,
  visible = false,
  shape = gears.shape.rounded_rect,
  widget = popupWidget,
}

cancelButton:connect_signal(
  "button::press",
  function()
    popup.visible = false
  end
)
shutdownButton:connect_signal(
  "button::press",
  function()
    awful.spawn.with_shell("poweroff")
  end
)
rebootButton:connect_signal(
  "button::press",
  function()
    awful.spawn.with_shell("reboot")
  end
)
logoutButton:connect_signal(
  "button::press",
  function()
    awful.spawn.with_shell("pkill -kill -u $USER")
  end
)

-- Create a compstats widget
widget = awful.widget.button({
  image = '/home/emilia/.local/share/icons/heart.svg',
  buttons = {
    awful.button({}, 1, function()
      popup.visible = not popup.visible
      popup.x = awful.screen.focused().geometry.x + awful.screen.focused().geometry.width / 2 - 200
      popup.y = awful.screen.focused().geometry.y + awful.screen.focused().geometry.height / 2 - 75
    end),
  },
})
widget.font = 'FiraCode Nerd Font Mono 12'

powermenu = wibox.widget {
  {
    {
      widget = widget
    },
    widget = wibox.container.margin,
    top = dpi(4),
    bottom = dpi(4),
    right = dpi(4),
    left = dpi(4),
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
}


local old_cursor, old_wibox
powermenu:connect_signal(
  'mouse::enter',
  function()
    local w = _G.mouse.current_wibox
    if w then
      old_cursor, old_wibox = w.cursor, w
      w.cursor = 'hand2'
    end
    powermenu.bg = '#ffffff11'
  end
)

powermenu:connect_signal(
  'mouse::leave',
  function()
    powermenu.bg = '#ffffff00'
    if old_wibox then
      old_wibox.cursor = old_cursor
    end
  end
)

return {
  powermenu,
  widget=wibox.container.margin,
  top = dpi(2),
  bottom = dpi(2),
  right = dpi(6),
  left = dpi(6),
}

