local dpi = require("beautiful.xresources").apply_dpi
local network = require("ui.bar.stats.network")
local compstats = require("ui.bar.stats.compstats")
local notifications = require("ui.bar.stats.notifications")
local display = require("ui.bar.stats.display")
local clickable_container = require("modules.clickable-container")


local function generate_button(icon, launcher, color, font)
  if font == nil then
    font = Font24
  end
  if color == nil then
    color = Beautiful.foreground
  end
  local widget = Helpers.bar_widget {
    {
      Wibox.widget.textbox(f "<span font='{font}' foreground='{color}'>{icon}</span>"),
      margins = dpi(6),
      widget = Wibox.container.margin,
    },
    widget = clickable_container,
    shape = Gears.shape.circle
  }
  widget:connect_signal(
    "button::press",
    function(_, _, _, button)
      if button == 1 then
        Awful.spawn(launcher)
      end
    end
  )
  return widget
end

local stats_widget = Helpers.bar_widget {
  {
    Wibox.widget.textbox(f "<span font='{Font18}' >󰇘</span>"),
    widget = Wibox.container.margin,
    margins = dpi(10),
  },
  widget = clickable_container,
  shape = Gears.shape.circle
}

local popup_width = dpi(400)

local popup = Awful.popup {
  ontop = true,
  visible = false,
  shape = Gears.shape.rounded_rect,
  widget = Wibox.widget {},
  border_width = Beautiful.border_width,
  border_color = Beautiful.border_color_active,
}

local function create_popup()
  return Wibox.widget {
    {
      {
        {
          network,
          compstats,
          layout = Wibox.layout.fixed.horizontal,
        },
        {
          {
            display,
            generate_button("", "lxappearance", Beautiful.yellow),
            generate_button("󰖩", "connman-gtk", Beautiful.orange),
            generate_button("󰄨", "alacritty --class floater -e htop", Beautiful.red),
            generate_button("", "pavucontrol", Beautiful.purple),
            generate_button("󰂯", "blueman-manager", Beautiful.blue, Font18),
            generate_button("󰡁", "nvidia-settings", Beautiful.green, Font18),
            layout = Wibox.layout.fixed.horizontal,
          },
          left = dpi(10),
          right = dpi(10),
          widget = Wibox.container.margin,
        },
        notifications(),
        layout = Wibox.layout.fixed.vertical,
      },
      top = dpi(5),
      bottom = dpi(10),
      widget = Wibox.container.margin,
    },
    widget = Wibox.container.background,
    forced_width = popup_width,
  }
end

popup:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      popup.visible = false
    end
  end
)

stats_widget:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      local popup_widget = create_popup()
      popup.widget = popup_widget
      popup.visible = not popup.visible
      local screen_x = Awful.screen.focused().geometry.x
      local screen_y = Awful.screen.focused().geometry.y
      local screen_w = Awful.screen.focused().geometry.width
      local gap = Beautiful.useless_gap * 2
      popup.x = screen_x + screen_w - popup_width - dpi(6)
      popup.y = screen_y + Beautiful.wibar_height + gap
    end
  end
)
popup:connect_signal(
  "mouse::leave",
  function()
    popup.visible = false
  end
)

return stats_widget
