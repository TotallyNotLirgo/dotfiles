Naughty.connect_signal("request::display_error", function(message, startup)
  message = message:gsub(HomeLocation .. ".config/awesome", "")
  Naughty.notification {
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message,
    timeout = 0,
    height = 200,
  }
end)


