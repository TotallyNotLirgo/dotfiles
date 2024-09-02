local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local clickable_container = require("modules.clickable-container")

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
local widget = awful.widget.button({
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

local powermenu = Helpers.bar_widget {
  {
    widget,
    margins = Beautiful.useless_gap * 2,
    widget = wibox.container.margin
  },
  shape = gears.shape.circle,
  widget = clickable_container,
}

return powermenu

