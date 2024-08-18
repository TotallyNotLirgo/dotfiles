local ui_textclock = require("ui.bar.textclock")
local ui_systray = require("ui.bar.systray")
local ui_tasklist = require("ui.bar.tasklist")
local ui_applauncher = require("ui.applauncher")
local ui_power_menu = require("ui.bar.power_menu")
local ui_network = require("ui.bar.network")
local ui_compstats = require("ui.bar.compstats")
local ui_sound_control = require("ui.bar.sound_control")
local ui_battery = require("ui.bar.battery")
local ui_display = require("ui.bar.display")
local stats_widget = require("ui.bar.stats")

screen.connect_signal("request::desktop_decoration", function(s)
  Awful.tag({ "  ", "  ", " 󰓓 ", " 󰝚 ", " 󰇘 ", " 󰇘 ", " 󰇘 " }, s, Awful.layout.layouts[1])

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
    spacing = 10,
    filter = Awful.widget.taglist.filter.all,
    style = {
      bg_focus = Beautiful.bg_focus,
      fg_focus = Beautiful.fg_normal,
      bg_normal = Beautiful.bg_normal,
      shape = Gears.shape.rounded_rect,
      font = Beautiful.taglist_font .. " 20"
    },
    buttons = { Awful.button({}, 1, function(t) t:view_only() end) },
    widget_template = {
      {
        {
          id = 'text_role',
          widget = Wibox.widget.textbox
        },
        id = 'background_role',
        widget = Wibox.container.background
      },
      widget = Wibox.container.margin,
      top = 3,
      bottom = 3,
      create_callback = function(self)
        local old_cursor, old_wibox
        self:connect_signal('mouse::enter', function(_)
          ---@diagnostic disable-next-line: undefined-field
          local w = _G.mouse.current_wibox
          if w then
            old_cursor, old_wibox = w.cursor, w
            w.cursor = 'hand2'
          end
        end)

        self:connect_signal('mouse::leave', function()
          if old_wibox then
            old_wibox.cursor = old_cursor
          end
        end)
      end,
    },
  }

  s.mytasklist = ui_tasklist
  s.mywibox = Awful.wibar({ position = "top", screen = s, height = Beautiful.wibar_height })

  s.mywibox.widget = {
    layout = Wibox.layout.align.horizontal,
    {
      ui_power_menu,
      s.mytaglist,
      layout = Wibox.layout.fixed.horizontal,
    },
    nil,
    {
      ui_network,
      ui_compstats,
      ui_sound_control,
      ui_systray,
      ui_battery,
      ui_display,
      ui_textclock,
      stats_widget,
      layout = Wibox.layout.fixed.horizontal,
    }
  }
end)
