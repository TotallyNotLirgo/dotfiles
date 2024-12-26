local awful = require("awful")
local menubar = require("menubar")
menubar.match_empty = true
menubar.show_categories = false
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
  awful.key({ ModKey }, "o", function() screen.primary.right_panel:toggle() end,
    { description = 'toggle notification center', group = 'Awesome' }),
  awful.key({ ModKey }, "z", function() awful.spawn("gpick -p") end, { description = 'Pick a color', group = 'XF86' }),
  awful.key({}, 'XF86AudioRaiseVolume', function() awful.spawn("pamixer -i 5") end,
    { description = 'volume up', group = 'XF86' }),
  awful.key({}, 'XF86AudioLowerVolume', function() awful.spawn("pamixer -d 5") end,
    { description = 'volume down', group = 'XF86' }),
  awful.key({}, 'XF86AudioMute', function() awful.spawn("pamixer -t") end, { description = 'toggle mute', group = 'XF86' }),
  awful.key({}, "XF86MonBrightnessUp", function() awful.spawn("brightnessctl s +5%") end,
    { description = "increase brightness", group = "XF86" }),
  awful.key({}, "XF86MonBrightnessDown", function() awful.spawn("brightnessctl s 5%-") end,
    { description = "decrease brightness", group = "XF86" }),

  awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end,
    { description = "play/pause", group = "XF86" }),
  awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end,
    { description = "next song", group = "XF86" }),
  awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end,
    { description = "previous song", group = "XF86" }),

  awful.key({ ModKey, "Control" }, "space", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ ModKey, "Shift" }, "s",
    function() awful.spawn.with_shell("scrot -s -f - | xclip -sel clipboard -t image/png") end,
    { description = "Take a screenshot", group = "custom" }),
  awful.key({ ModKey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ ModKey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ ModKey }, "Return", function()
      local index = awful.screen.focused().selected_tag.index
      if index == 1 then
        awful.spawn(Browser)
      elseif index == 2 then
        awful.spawn(Terminal)
      elseif index == 3 then
        awful.spawn("steam")
      elseif index == 4 then
        awful.spawn("spotify")
      else
        awful.spawn(Terminal)
      end
    end,
    { description = "Open a dedicated application", group = "launcher" }),
  awful.key({ ModKey }, "space", function()
    awful.spawn.with_shell("rofi -show drun -show-icons")
  end, { description = "show the menubar", group = "launcher" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ ModKey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ ModKey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ ModKey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
  awful.key({ AltKey }, "Tab", function() awesome.emit_signal("bling::window_switcher::turn_on") end,
    { description = "Window Switcher", group = "bling" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ ModKey }, "j", function() awful.client.focus.byidx(1) end,
    { description = "focus next by index", group = "client" }),
  awful.key({ ModKey }, "k", function() awful.client.focus.byidx(-1) end,
    { description = "focus previous by index", group = "client" }),
  awful.key({ ModKey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ ModKey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ ModKey, "Control" }, "n",
    function()
      local c = awful.client.restore()
      if c then c:activate { raise = true, context = "key.unminimize" } end
    end, { description = "restore minimized", group = "client" })
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ ModKey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ ModKey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ ModKey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ ModKey }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ ModKey }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ ModKey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ ModKey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ ModKey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ ModKey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ ModKey, "Shift" }, "space", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" })
})

-- Numpad and Numrow related keybinds
awful.keyboard.append_global_keybindings({
  awful.key {
    modifiers = { ModKey },
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then tag:view_only() end
    end },
  awful.key {
    modifiers = { ModKey, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
          awful.tag.viewonly(tag)
        end
      end
    end },
  awful.key {
    modifiers = { ModKey, "Control", "Shift" },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then client.focus:toggle_tag(tag) end
      end
    end },
})

-- Default mousebindings
client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c) c:activate { context = "mouse_click" } end),
    awful.button({ ModKey }, 1, function(c) c:activate { context = "mouse_click", action = "mouse_move" } end),
    awful.button({ ModKey }, 3, function(c) c:activate { context = "mouse_click", action = "mouse_resize" } end)
  })
end)

-- Default client keybindings
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ ModKey }, "f",
      function(c)
        if c.fullscreen then
          c.fullscreen = false
          c.maximized = false
          c.floating = true
          awful.titlebar.show(c)
        else
          awful.titlebar.hide(c)
          c.fullscreen = true
        end
        c:raise()
      end,
      { description = "toggle fullscreen", group = "client" }),
    awful.key({ ModKey }, "q",
      function(c)
        c:kill()
      end,
      { description = "close", group = "client" }),
    awful.key({ ModKey }, "s",
      function(c)
        c.fullscreen = false
        c.maximized = false
        c.floating = not c.floating
        local x = awful.screen.focused().geometry.x
        local y = awful.screen.focused().geometry.y
        local sw = awful.screen.focused().geometry.width
        local sh = awful.screen.focused().geometry.height
        c:geometry({
          x = x + sw / 7,
          y = y + sh / 7,
          width = sw / 1.4,
          height = sh / 1.4
        })
        if c.floating then
          awful.titlebar.show(c)
        else
          awful.titlebar.hide(c)
        end
      end,
      { description = "toggle floating", group = "client" }),
    awful.key({ ModKey, "Shift" }, "t",
      function(c)
        awful.titlebar.toggle(c)
      end,
      { description = "toggle titlebars", group = "client" }),
    awful.key({ ModKey, AltKey }, "h",
      function(c)
        c.skip_taskbar = not c.skip_taskbar
      end,
      { description = "toggle titlebars", group = "client" }),
    awful.key({ ModKey, "Control" }, "Return",
      function(c)
        c:swap(awful.client.getmaster())
      end,
      { description = "move to master", group = "client" }),
    awful.key({ ModKey }, "t",
      function(c)
        c.ontop = not c.ontop
      end,
      { description = "toggle keep on top", group = "client" }),
    awful.key({ ModKey }, "n",
      function(c)
        c.minimized = true
      end,
      { description = "minimize", group = "client" }),
    awful.key({ ModKey }, "m",
      function(c)
        c.maximized = not c.maximized
        awful.titlebar.hide(c)
        c:raise()
      end,
      { description = "(un)maximize", group = "client" }),
    awful.key({ ModKey, "Control" }, "m",
      function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end,
      { description = "(un)maximize vertically", group = "client" }),
    awful.key({ ModKey, "Shift" }, "m",
      function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end,
      { description = "(un)maximize horizontally", group = "client" })
  })
end)

-- }}}
