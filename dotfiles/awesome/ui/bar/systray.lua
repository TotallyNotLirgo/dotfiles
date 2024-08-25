local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local systray = wibox.widget {
    {
        wibox.widget.systray,
        widget = wibox.container.margin,
        margins = dpi(5),
    },
    widget = wibox.container.background,
}

return systray
