local dpi = Beautiful.xresources.apply_dpi
local helpers = require("helpers")
local ruled = require("ruled")

-- Naughty.connect_signal("request::icon", function(n, context, hints)
--     if context ~= "app_icon" then return end
--     n.icon = theme.awesome_icon
-- end)

require("ui.notifs.brightness")
require("ui.notifs.volume")

local border_radius = Beautiful.border_radius or dpi(6)

Naughty.config.defaults.ontop = true
Naughty.config.defaults.screen = Awful.screen.focused()
Naughty.config.defaults.timeout = 3
Naughty.config.defaults.title = "System Notification"
Naughty.config.defaults.position = "top_right"

-- Timeouts
Naughty.config.presets.low.timeout = 3
Naughty.config.presets.critical.timeout = 0

Naughty.config.presets.normal = {
    font = Beautiful.font,
    fg = Beautiful.fg_normal,
    bg = Beautiful.bg_normal
}

Naughty.config.presets.low = {
    font = Beautiful.font,
    fg = Beautiful.fg_normal,
    bg = Beautiful.bg_normal
}

Naughty.config.presets.critical = {
    font = Beautiful.font .. "10",
    fg = Beautiful.red,
    bg = Beautiful.bg_normal,
    timeout = 0
}

Naughty.config.presets.ok = Naughty.config.presets.normal
Naughty.config.presets.info = Naughty.config.presets.normal
Naughty.config.presets.warn = Naughty.config.presets.critical

ruled.notification.connect_signal("request::rules", function()
    ruled.notification.append_rule {
        rule = {},
        properties = { screen = Awful.screen.preferred, implicit_timeout = 6 }
    }
end)

Naughty.connect_signal("request::display", function(n)
    local time = os.date("%H:%M")
    n.time = time
    awesome.emit_signal("signal::new_notification", n)

    local action_widget = {
        {
            {
                id = "text_role",
                align = "center",
                valign = "center",
                font = Beautiful.font .. "8",
                widget = Wibox.widget.textbox
            },
            margins = dpi(6),
            widget = Wibox.container.margin
        },
        bg = Beautiful.bg_normal,
        shape = helpers.rrect(dpi(4)),
        widget = Wibox.container.background
    }

    local actions = Wibox.widget {
        notification = n,
        base_layout = Wibox.widget {
            spacing = dpi(8),
            layout = Wibox.layout.flex.horizontal
        },
        widget_template = action_widget,
        style = { underline_normal = false, underline_selected = true },
        widget = Naughty.list.actions
    }

    Naughty.layout.box {
        notification = n,
        type = "notification",
        bg = Beautiful.bg_normal,
        widget_template = {
            {
                {
                    {
                        {
                            Wibox.widget.textbox(n.app_name),
                            nil,
                            Wibox.widget.textbox(time),
                            layout = Wibox.layout.align.horizontal
                        },
                        margins = dpi(4),
                        widget = Wibox.container.margin
                    },
                    bg = Beautiful.bg1,
                    widget = Wibox.container.background
                },
                {
                    {
                        {
                            {
                                step_function = Wibox.container.scroll.step_functions.nonlinear_back_and_forth,
                                Wibox.widget.textbox("<span weight='bold'>" .. n.title .. "</span>"),
                                forced_width = dpi(320),
                                speed = 50,
                                widget = Wibox.container.scroll.horizontal
                            },
                            {
                                step_function = Wibox.container.scroll.step_functions.nonlinear_back_and_forth,
                                Wibox.widget.textbox(n.message),
                                forced_width = dpi(320),
                                speed = 50,
                                widget = Wibox.container.scroll.horizontal
                            },
                            layout = Wibox.layout.flex.vertical
                        },
                        {
                            Wibox.widget.imagebox(n.icon),
                            strategy = "max",
                            height = 40,
                            widget = Wibox.container.constraint
                        },
                        spacing = dpi(4),
                        layout = Wibox.layout.fixed.horizontal
                    },
                    margins = dpi(10),
                    widget = Wibox.container.margin
                },
                {
                    actions,
                    margins = dpi(10),
                    visible = n.actions and #n.actions > 0,
                    widget = Wibox.container.margin
                },
                layout = Wibox.layout.fixed.vertical
            },
            bg = Beautiful.black,
            border_width = 0,
            border_color = Beautiful.widget_border_color,
            shape = helpers.rrect(border_radius),
            widget = Wibox.container.background
        }
    }
end)
