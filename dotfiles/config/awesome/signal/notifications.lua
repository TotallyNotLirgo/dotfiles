local notifications = {}

awesome.connect_signal("signal::new_notification", function(notification)
  table.insert(notifications, notification)
  if #notifications > 5 then
    table.remove(notifications, 1)
  end
  awesome.emit_signal("signal::notifications", notifications)
end)
