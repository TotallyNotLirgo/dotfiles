local titlebar_buttons = require("ui.bar.titlebar_buttons")

client.connect_signal("request::titlebars", function(c)
  local top_titlebar = Awful.titlebar(c, {})
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
      titlebar_buttons.sticky_button(c),
      titlebar_buttons.floating_button(c),
      titlebar_buttons.close_button(c),
      layout = Wibox.layout.fixed.horizontal()
    },
    layout = Wibox.layout.align.horizontal,
    widget = Wibox.container.margin,
    margins = 2,
  }
end)
