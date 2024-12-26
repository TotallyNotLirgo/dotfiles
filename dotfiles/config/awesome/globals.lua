ModKey = "Mod4"
Font = "FiraCode Nerd Font Mono"
Font12 = Font .. " 12"
Font18 = Font .. " 18"
Font24 = Font .. " 24"
Font32 = Font .. " 32"
AltKey = "Mod1"
Terminal = "alacritty"
Editor = "nvim"
Browser = "brave"
FileManager = "nemo"

Wibox = require("wibox")
Awful = require("awful")
Gears = require("gears")
Beautiful = require("beautiful")
Naughty = require("naughty")
Ruled = require "ruled"
require("modules.fstring")
HomeLocation = "/home/emilia/"
AwesomeLocation = HomeLocation .. ".config/awesome/"
Helpers = require("helpers")
