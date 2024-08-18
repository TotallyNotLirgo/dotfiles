local awful = require("awful")

local autostart_apps = {
    "xset -b", -- Disable bell
    "bash -c 'dbus-update-activation-environment DISPLAY'",
    "blueman-applet", -- Bluetooth Systray Applet
    "picom", -- Compositor
    "nm-applet --indicator", -- network manager systray applet
    "xfce4-power-manager", -- start the power manager
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1", -- polkit
}

for app = 1, #autostart_apps do
    awful.spawn.single_instance(autostart_apps[app], awful.rules.rules)
end
