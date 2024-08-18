tag.connect_signal("request::default_layouts", function()
  Awful.layout.append_default_layouts({ Awful.layout.suit.fair })
end)
