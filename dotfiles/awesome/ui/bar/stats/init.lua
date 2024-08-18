local dpi = require("beautiful.xresources").apply_dpi

local stats_widget = Helpers.bar_widget {
  {
    Wibox.widget.textbox(f "<span font='{Font18}' >󰇘</span>"),
    widget = Wibox.container.margin,
    margins = dpi(10),
  },
  widget = clickable_container,
  shape = Gears.shape.circle
}
local action_1 = Naughty.action({ name = "Ok" })
local action_2 = Naughty.action({ name = "Cancel" })
action_1:connect_signal(
  "invoked",
  function() Naughty.notify({ title = "Stats", text = "Ok button clicked!" }) end
)
action_2:connect_signal(
  "invoked",
  function() Naughty.notify({ title = "Stats", text = "Cancel button clicked!" }) end
)

stats_widget:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      Naughty.notify({
        title = "Stats",
        app_name = "AwesomeWM",
        text = "Stats widget clicked!",
        timeout = 2,
        urgency = "critical",
        icon = AwesomeLocation .. "resources/icons/heart.svg",
        image = AwesomeLocation .. "resources/icons/default-artwork.png",
        actions = { action_1, action_2 }
      })
    end
  end
)

return stats_widget
