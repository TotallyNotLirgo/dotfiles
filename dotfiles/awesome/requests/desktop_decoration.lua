local clickable_container = require("modules.clickable-container")
local ui_textclock = require("ui.bar.textclock")
local ui_systray = require("ui.bar.systray")
local ui_tasklist = require("ui.bar.tasklist")
local ui_applauncher = require("ui.applauncher")
local ui_power_menu = require("ui.bar.power_menu")
local ui_sound_control = require("ui.bar.sound_control")
local ui_battery = require("ui.bar.battery")
local stats_widget = require("ui.bar.stats")

screen.connect_signal("request::desktop_decoration", function(s)
  Awful.tag({ "", "", "󰓓", "󰝚", "󰇘", "󰇘", "󰇘" }, s, Awful.layout.layouts[1])

  Awful.popup {
    ontop = false,
    visible = true,
    shape = Gears.shape.rounded_bar,
    widget = ui_applauncher,
    x = s.geometry.x + s.geometry.width / 2 - 220,
    y = s.geometry.y + s.geometry.height - 60,
  }

  s.mytaglist = Awful.widget.taglist {
    screen = s,
    spacing = Beautiful.useless_gap,
    filter = Awful.widget.taglist.filter.all,
    style = {
      bg_focus = Beautiful.bg_focus,
      fg_focus = Beautiful.fg_normal,
      bg_normal = Beautiful.bg_normal,
      shape = Gears.shape.circle,
      font = Beautiful.taglist_font .. " 20"
    },
    buttons = { Awful.button({}, 1, function(t) t:view_only() end) },
    widget_template = {
      {
        {
          {
            {
              id = 'text_role',
              widget = Wibox.widget.textbox
            },
            left = 12,
            right = 12,
            widget = Wibox.container.margin
          },
          id = 'background_role',
          widget = Wibox.container.background
        },
        widget = clickable_container,
        shape = Gears.shape.circle,
        forced_width = 40,
        forced_height = 40,
      },
      widget = Wibox.container.margin,
      top = Beautiful.useless_gap,
      bottom = Beautiful.useless_gap,
    },
  }

  s.mywibox = Awful.wibar({ position = "top", screen = s, height = Beautiful.wibar_height })

  s.mywibox.widget = {
    {
      {
        ui_power_menu,
        s.mytaglist,
        ui_tasklist(s),
        layout = Wibox.layout.fixed.horizontal,
      },
      nil,
      {
        ui_systray,
        ui_sound_control,
        ui_textclock,
        ui_battery,
        stats_widget,
        layout = Wibox.layout.fixed.horizontal,
      },
      layout = Wibox.layout.align.horizontal,
    },
    left = Beautiful.useless_gap,
    right = Beautiful.useless_gap,
    widget = Wibox.container.margin,
  }
end)

client.connect_signal("request::manage", function(c)
    c.shape = function(cr, w, h)
        Gears.shape.rounded_rect(cr, w, h, 10)
    end
end)
