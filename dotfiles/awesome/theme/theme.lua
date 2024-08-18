local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local colors = require("theme.colors")
local xrdb = xresources.get_current_theme()

local theme = {}
theme.darker_bg = "#10171e"
theme.lighter_bg = "#1f272e"
theme.xbackground = xrdb.background or "#131a21"
theme.xforeground = xrdb.foreground or "#ffffff"
theme.xcolor0 = xrdb.color0 or "#29343d"
theme.xcolor1 = xrdb.color1 or "#f9929b"
theme.xcolor2 = xrdb.color2 or "#7ed491"
theme.xcolor3 = xrdb.color3 or "#fbdf90"
theme.xcolor4 = xrdb.color4 or "#a3b8ef"
theme.xcolor5 = xrdb.color5 or "#ccaced"
theme.xcolor6 = xrdb.color6 or "#9ce5c0"
theme.xcolor7 = xrdb.color7 or "#ffffff"
theme.xcolor8 = xrdb.color8 or "#3b4b58"
theme.xcolor9 = xrdb.color9 or "#fca2aa"
theme.xcolor10 = xrdb.color10 or "#a5d4af"
theme.xcolor11 = xrdb.color11 or "#fbeab9"
theme.xcolor12 = xrdb.color12 or "#bac8ef"
theme.xcolor13 = xrdb.color13 or "#d7c1ed"
theme.xcolor14 = xrdb.color14 or "#c7e5d6"
theme.xcolor15 = xrdb.color15 or "#eaeaea"

theme.font = Font
theme.taglist_font = Font

theme.bg_normal = colors.background
theme.bg_focus = colors.selection
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
theme.titlebar_bg_focus = colors.background_dark
theme.titlebar_bg_normal = colors.background
theme.titlebar_fg_normal = theme.fg_normal .. "50"
theme.titlebar_fg_focus = theme.fg_normal

theme.border_width = dpi(1)
theme.border_color_normal = colors.background_dark
theme.border_color_active = colors.comment
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
