local awful = require "awful"
local beautiful = require "beautiful"
local ruled = require "ruled"

-- {{{ Rules
-- Rules to apply to new clients.

ruled.client.connect_signal("request::rules", function()

  -- All clients will match this rule.
  ruled.client.append_rule {
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.centered  + awful.placement.no_offscreen,
    }
  }

  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule {
    id = "titlebars",
    rule_any = {
      type = {
        "Wine", "NetBeans IDE 8.2", "sun-awt-X11-XFramePeer"
      }
    },
    properties = {titlebars_enabled = true}
  }

  -- Picture in picture
  ruled.client.append_rule {
    id = "Picture in picture",
    rule_any = {
      name = {"Picture-in-picture"}
    },
    properties = {
      ontop = true,
      floating = true,
    }
  }

  -- removing border and tiling for teamviewer
  ruled.client.append_rule {
    id = "Teamviewer",
    rule_any = {
      class = {"TeamViewer"}
    },
    properties = {
      border_width = 0,
      floating = true,
    }
  }



  -- Floating clients.
  ruled.client.append_rule {
    id = "floating",
    rule_any = {
      instance = {
        "copyq",
        "pinentry"
      },
      class = {
        "Gpick", "Kruler", "Sxiv",
        "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer", "Wine",
        "CPU Simulator", "matplotlib", "Wihotspot-gui",
        "floater"
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown thfloatingere might not match defined rules here.
      name = {
        "Event Tester", -- xev.
        "Volume Control",
        "PlayOnLinux",
        "Friends List"
        -- "Picture in picture"
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        -- "ConfigManager", -- Thunderbird's about:config.
        "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    except_any = {
      class = {"crx_peoigcfhkflakdcipcclkneidghaaphd"},
      name = {"csTimer"}
    },
    properties = {
      floating = true,
      titlebars_enabled = true,
      ontop = true,
    }
  }
  ruled.client.append_rule {
    rule_any = {
      class = {
        ".arandr-wrapped",
        ".blueman-manager-wrapped",
        "pavucontrol",
        "nm-connection-editor"
      },
    },
    properties = {
      floating = true,
      titlebars_enabled = true,
      ontop = true,
    },
    callback = function(c)
      local xs = awful.screen.focused().geometry.x
      local ys = awful.screen.focused().geometry.y
      local ws = awful.screen.focused().geometry.width
      local hs = awful.screen.focused().geometry.height
      c.width = ws / 1.4
      c.height = hs / 1.4
      c.x = xs + (ws - c.width) / 2
      c.y = ys + (hs - c.height) / 2
    end
  }

  ruled.client.append_rule {
    id = "Cs timer",
    rule_any = {
      -- class = {"crx_peoigcfhkflakdcipcclkneidghaaphd"},
      name = {"csTimer"}

    },
    properties = {
      tiled = true,
    }
  }

end)

-- }}}
