pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")
require("awful.hotkeys_popup.keys")
local dpi = require("beautiful.xresources").apply_dpi

beautiful.init(require("theme.theme"))

awesome.register_xproperty("WM_CLASS","string")
require "configuration"
require "signal"
require "ui"
modkey = "Mod4"
awful.spawn.with_shell("setxkbmap pl")

-- Notifications settings
-- require('notifications')

-- Initializing widgets
local mytextclock = require("ui.bar.textclock")
local systray = require("ui.bar.systray")
local mytasklist = require("ui.bar.tasklist")
-- require("widgets.dock.dock")
-- local animationwidget = require("widgets.animationwidget")



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title = "Oops, an error happened" ..
      (startup and " during startup!" or "!"),
    message = message
  }
end)
client.connect_signal("request::titlebars", function(c)
  local top_titlebar = awful.titlebar(c, {})
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      client.focus = c
      c:raise()
      awful.mouse.client.resize(c)
    end)
  )
  local titlebar_buttons = require("ui.bar.titlebar_buttons")
  top_titlebar : setup {
    {
      {
        {
          {
            widget = awful.titlebar.widget.titlewidget(c),
            font = "FiraCode Nerd Font Mono 12"
          },
          widget = wibox.container.margin,
          left = 10,
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
      },
      {
        widget = wibox.container.margin,
        buttons = buttons,
      },
      {
        titlebar_buttons.sticky_button(c),
        titlebar_buttons.floating_button(c),
        titlebar_buttons.close_button(c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    },
    widget = wibox.container.margin,
    margins = 2,
  }
end)



-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  {
    "hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end
  },
  {"manual", terminal .. " -e man awesome"},
  {"edit config",
    function()
      awful.spawn("code .config/awesome")
    end
  },
  {"restart", awesome.restart},
  {"quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({
  items = {
    {"awesome", myawesomemenu, beautiful.awesome_icon},
    {"open terminal", terminal},
    {"system monitor", terminal .. " -e btop --utf-force"}
  }
})

mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Tag
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    awful.layout.suit.fair,
  })
end)
-- }}}

-- {{{ Wibar


-- Desktop decorations
screen.connect_signal("request::desktop_decoration", function(s)
  -- Each screen has its own tag table.
  awful.tag({"  ", "  ", " 󰓓 ", " 󰝚 ", " 󰇘 ", " 󰇘 ", " 󰇘 "},s, awful.layout.layouts[1])

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox = awful.widget.layoutbox { screen = s, }

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    spacing = 10,
    filter = awful.widget.taglist.filter.all,
    style = {
      bg_focus = beautiful.bg_focus,
      fg_focus = beautiful.fg_normal,
      bg_normal = beautiful.bg_normal,
      shape = gears.shape.rounded_rect,
      font = beautiful.taglist_font .. " 20"
    },
    buttons = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({modkey}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
      end),
      awful.button({}, 4, function(t)
        awful.tag.viewprev(t.screen)
      end),
      awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
      end)
    },
    widget_template = {
      {
        {
          id     = 'text_role',
          widget = wibox.widget.textbox,
          -- forced_width = 17
        },
        id     = 'background_role',
        widget = wibox.container.background,
      },
      widget = wibox.container.margin,
      top = 3,
      bottom = 3,
      create_callback = function(self, c3, index, objects) --luacheck: no unused args
        local old_cursor, old_wibox
        self:get_children_by_id('text_role')[1].markup = '<b> '..index..' </b>'
        self:connect_signal('mouse::enter', function(w)
            local w = _G.mouse.current_wibox
            if w then
              old_cursor, old_wibox = w.cursor, w
              w.cursor = 'hand2'
            end

          -- BLING: Only show widget when there are clients in the tag
          if #c3:clients() > 0 then
            -- BLING: Update the widget with the new tag
            awesome.emit_signal("bling::tag_preview::update", c3)
            -- BLING: Show the widget
            awesome.emit_signal("bling::tag_preview::visibility", s, true)
          end

          if self.bg ~= '#ff0000' then
            self.backup     = self.bg
            self.has_backup = true
          end
          self.bg = '#ff0000'
        end)

        self:connect_signal('mouse::leave', function()
            if old_wibox then
              old_wibox.cursor = old_cursor
            end
          -- BLING: Turn the widget off
          awesome.emit_signal("bling::tag_preview::visibility", s, false)

          if self.has_backup then self.bg = self.backup end
        end)
      end,
      update_callback = function(self, c3, index, objects) --luacheck: no unused args
        self:get_children_by_id('text_role')[1].markup = '<b> '..index..' </b>'
      end,
    },
  }
  -- s.mytaglist = require("ui.bar.pacman_taglist")(s)

  -- Create a tasklist widget
  s.mytasklist = mytasklist

  -- Create the wibox
  s.mywibox = awful.wibar({position="top", screen = s, height = beautiful.wibar_height})

  s.mypromptbox = awful.widget.prompt()
  s.mywibox.widget = {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      -- wibox.container.background(
      --  "#101010"),
      require("ui.bar.power_menu"),
      s.mytaglist,
      s.mypromptbox,
    },
    { -- Middle widgets
      nil,
      nil,
      -- mytextclock,
      nil,
      layout = wibox.layout.align.horizontal,
      expand = "outside",
    },
    {
      layout = wibox.layout.fixed.horizontal,
      require("ui.bar.network"),
      require("ui.bar.compstats"),
      require("ui.bar.sound_control"),
      systray,
      require("ui.bar.display"),
      mytextclock,
      -- require("ui.bar.battery"),
    }
  }

end)
-- }}}

awful.keyboard.append_global_keybindings({
  awful.key({"Mod4"}, "/",
    function()
      awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"}),
})




-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate{context = "mouse_enter", raise = false}
end)

-- Make the focused window have a glowing border
client.connect_signal('focus', function(c)
  c.border_color = beautiful.border_color_active
end)
client.connect_signal('unfocus', function(c)
  c.border_color = beautiful.border_color_normal
end)

local buttons_example = wibox {
  visible = false,
  -- bg = '#333333',
  ontop = true,
  height = 230,
  width = 420,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 3)
  end
}

local button = wibox.widget{
  {
    {
      text = "I'm a button!",
      widget = wibox.widget.textbox,
      -- bg = "#333333"
    },
    layout = wibox.container.place,
    valigh = 'center',
  },
  widget = wibox.container.background,
  bg = "#333333",
}

local bottom_right_indent = wibox.widget {
  -- {
  button,
  -- },
  widget = wibox.container.margin,
  bottom = 2,
  right = 2,
  color = "#5d5d5d"
}

local top_left_indent = wibox.widget {
  bottom_right_indent,
  widget  = wibox.container.margin,
  top = 2,
  left = 2,
  color = "#131313"
}

buttons_example:setup {
  top_left_indent,
  widget = wibox.container.margin,
  margins = 100,
  color = "#333333"
}

local temp

top_left_indent:connect_signal(
  "button::press",
  function()
    temp = top_left_indent.color
    top_left_indent.color = bottom_right_indent.color
    bottom_right_indent.color = temp
  end
)

awful.placement.centered(buttons_example, { margins = {top = 40}, parent = awful.screen.focused()})


