local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local colors = require("theme.colors")

local theme = colors

theme.font = Font
theme.taglist_font = Font

theme.bg_normal = colors.bg0
theme.bg_focus = colors.grey
theme.bg_minimize = theme.bg_normal

theme.fg_normal = colors.foreground
theme.fg_focus = colors.fg_normal
theme.fg_urgent = colors.purple
theme.fg_minimize = theme.fg_normal

theme.systray_icon_spacing = dpi(2)
theme.useless_gap = dpi(2)
theme.gap_single_client = true

-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- notification_[bg|fg|width|height|margin|border_color|border_width|shape|opacity]
theme.titlebar_bg_focus = colors.bg_d
theme.titlebar_bg_normal = colors.bg0
theme.titlebar_fg_normal = theme.fg_normal .. "50"
theme.titlebar_fg_focus = theme.fg_normal

theme.border_width = dpi(1)
theme.border_color_normal = colors.bg_d
theme.border_color_active = colors.bg_blue
theme.border_color_marked = colors.purple
theme.border_single_client = false

theme.notification_font = theme.font
theme.notification_bg = theme.bg_normal

theme.menu_height = dpi(0)
theme.menu_width = dpi(0)
theme.wibar_height = dpi(35)

theme.wallpaper = AwesomeLocation .. "resources/backgrounds/NixOSWallpaper.png"

theme.awesome_icon = AwesomeLocation .. "resources/icons/heart.svg"

rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule = { urgency = 'critical' },
        properties = { bg = colors.red, fg = colors.foreground }
    }
end)

return theme
