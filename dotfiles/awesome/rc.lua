pcall(require, "luarocks.loader")
require("globals")

require("requests.display_error")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

Beautiful.init(require("theme.theme"))

awesome.register_xproperty("WM_CLASS", "string")

require "configuration"
require "signal"
require "ui"
Awful.spawn.with_shell("setxkbmap pl")

require("requests.wallpaper")
require("requests.titlebars")
require("requests.default_layouts")
require("requests.desktop_decoration")

client.connect_signal("mouse::enter", function(c)
  c:activate { context = "mouse_enter", raise = false }
end)

client.connect_signal('focus', function(c)
  c.border_color = Beautiful.border_color_active
end)
client.connect_signal('unfocus', function(c)
  c.border_color = Beautiful.border_color_normal
end)
