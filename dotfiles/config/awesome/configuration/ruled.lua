Ruled.client.connect_signal("request::rules", function()
  Ruled.client.append_rule {
    id = "global",
    rule = {},
    except_any = { class = { "Alacritty", "Brave-browser", "Spotify" } },
    properties = {
      floating = true,
      titlebars_enabled = true,
      raise = true,
    },
    callback = function(c)
      local xs = Awful.screen.focused().geometry.x
      local ys = Awful.screen.focused().geometry.y
      local ws = Awful.screen.focused().geometry.width
      local hs = Awful.screen.focused().geometry.height
      if c.width > ws / 1.4 then
        c.width = ws / 1.4
      end
      if c.height > hs / 1.4 then
        c.height = hs / 1.4
      end
      c.x = xs + (ws - c.width) / 2
      c.y = ys + (hs - c.height) / 2
    end
  }
  Ruled.client.append_rule {
    id = "global",
    rule_any = { class = { "Alacritty", "Brave-browser", "Spotify" } },
    properties = {
      focus = Awful.client.focus.filter,
      raise = true,
      screen = Awful.screen.preferred,
      placement = Awful.placement.centered + Awful.placement.no_offscreen,
    }
  }
end)
