local awful = require("awful")

local autostart_apps = {
    "xset -b", -- Disable bell
    "bash -c 'dbus-update-activation-environment DISPLAY'",
    "picom", -- Compositor
    "xfce4-power-manager", -- start the power manager
}
local on_restart_apps = {
    "bash -c '" .. HomeLocation .. ".local/bin/correct_screen'", -- Screen correction
}

for app = 1, #autostart_apps do
    awful.spawn.single_instance(autostart_apps[app], awful.rules.rules)
end

for app = 1, #on_restart_apps do
    awful.spawn(on_restart_apps[app])
end
