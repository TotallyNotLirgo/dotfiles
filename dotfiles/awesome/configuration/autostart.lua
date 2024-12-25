local awful = require("awful")

local autostart_apps = {
    "xset -b", -- Disable bell
    "bash -c 'dbus-update-activation-environment DISPLAY'",
    "bash -c '" .. HomeLocation .. ".local/bin/correct_screen'", -- Screen correction
    "picom", -- Compositor
    "xfce4-power-manager", -- start the power manager
}

for app = 1, #autostart_apps do
    awful.spawn.single_instance(autostart_apps[app], awful.rules.rules)
end
