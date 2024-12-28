local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local clickable_container = require("modules.clickable-container")

local header = wibox.widget.textbox("<span weight='bold'>Notifications (0):</span>")
header.font = Font12

local notifications = {}

local function map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

awesome.connect_signal(
  'signal::notifications',
  function(_notifications)
    if _notifications == nil then
      return
    end
    notifications = _notifications
  end
)

local function get_notifications()
  local rev = {}
  for i=#notifications, 1, -1 do
      rev[#rev+1] = notifications[i]
  end
  return map(rev, function(n)
    local widget = wibox.widget {
      {
        {
          {
            {
              {
                widget = wibox.widget.imagebox(n.icon),
                forced_width = dpi(30),
                forced_height = dpi(30),
              },
              widget = wibox.container.margin,
              left = dpi(4),
              right = dpi(4),
              top = dpi(5),
              bottom = dpi(5),
            },
            {
              {
                {
                  forced_height = dpi(20),
                  forced_width = dpi(250),
                  widget = wibox.widget.textbox("<b>" .. n.title .. "</b>"),
                },
                nil,
                {
                  widget = wibox.widget.textbox(n.time),
                  forced_height = dpi(20),
                  forced_width = dpi(50),
                },
                layout = wibox.layout.align.horizontal,
              },
              {
                ellipsize = "end",
                valign = "bottom",
                widget = wibox.widget.textbox(n.message),
                forced_height = dpi(20),
                forced_width = dpi(380),
              },
              layout = wibox.layout.fixed.vertical,
              spacing = Beautiful.useless_gap,
            },
            layout = wibox.layout.fixed.horizontal,
            spacing = Beautiful.useless_gap,
          },
          widget = wibox.container.margin,
          left = dpi(10),
          right = dpi(10),
          top = Beautiful.useless_gap,
          bottom = Beautiful.useless_gap,
        },
        widget = clickable_container,
      },
      widget = wibox.container.background,
      shape = Gears.shape.rounded_bar,
    }
    widget:connect_signal(
      "button::press",
      function(_, _, _, button)
        if button == 1 then
          Naughty.notify {
            title = n.title,
            message = n.message,
            app_name = n.app_name,
            icon = n.icon,
            actions = n.actions,
            timeout = 5,
          }
        end
      end
    )
    return widget
  end)
end

local function create_notificaton_widget()
  ---@diagnostic disable-next-line: unused-local
  local notification_n = #notifications
  if notification_n >= 5 then
    ---@diagnostic disable-next-line: cast-local-type
    notification_n = "5+"
  end
  if notification_n == 0 then
    return nil
  end
  header.markup = "<span weight='bold'>Notifications (" .. notification_n .. "):</span>"
  local actual_notifications = get_notifications()
  actual_notifications.layout = wibox.layout.fixed.vertical
  actual_notifications.spacing = Beautiful.useless_gap * 2
  return wibox.widget {
    {
      {
        { widget = header, forced_height = dpi(30) },
        actual_notifications,
        layout = wibox.layout.fixed.vertical,
        spacing = Beautiful.useless_gap,
     },
      widget = wibox.container.margin,
      left = dpi(8),
      right = dpi(8),
      top = dpi(4),
      bottom = dpi(4),
    },
    widget = wibox.container.background,
  }
end
return create_notificaton_widget
