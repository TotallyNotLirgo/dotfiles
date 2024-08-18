Naughty.connect_signal("request::display_error", function(message, startup)
  Naughty.notification {
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message
  }
end)


