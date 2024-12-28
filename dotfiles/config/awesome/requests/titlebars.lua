local titlebar_buttons = require("ui.titlebar_buttons")

client.connect_signal("request::titlebars", function(c)
  local top_titlebar = Awful.titlebar(c, {})
  top_titlebar.enable_tooltip = false
  local buttons = Gears.table.join(
    Awful.button({}, 1, function()
      client.focus = c
      c:raise()
      Awful.mouse.client.move(c)
    end),
    Awful.button({}, 3, function()
      client.focus = c
      c:raise()
      Awful.mouse.client.resize(c)
    end)
  )
  top_titlebar:setup {
    {
      Awful.titlebar.widget.titlewidget(c),
      font = Font12,
      widget = Wibox.container.margin,
      left = 10,
      buttons = buttons,
    },
    {
      widget = Wibox.container.margin,
      buttons = buttons,
    },
    {
      titlebar_buttons.StickyButton:get_widget(c),
      titlebar_buttons.FloatingButton:get_widget(c),
      titlebar_buttons.CloseButton:get_widget(c),
      layout = Wibox.layout.fixed.horizontal(),
      forced_width = 100,
    },
    layout = Wibox.layout.align.horizontal,
    expand = "none",
    widget = Wibox.container.margin,
    margins = 2,
  }
end)
