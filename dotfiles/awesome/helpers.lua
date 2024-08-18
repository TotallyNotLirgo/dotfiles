local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = {}

function helpers.find(rule)
    local function matcher(c) return awful.rules.match(c, rule) end
    local clients = client.get()
    local findex = gears.table.hasitem(clients, client.focus) or 1
    local start = gears.math.cycle(#clients, findex + 1)

    local matches = {}
    for c in awful.client.iterate(matcher, start) do
        matches[#matches + 1] = c
    end

    return matches
end

function helpers.bar_widget(widget)
    return wibox.widget {
        {
            widget,
            top = Beautiful.useless_gap,
            bottom = Beautiful.useless_gap,
            right = Beautiful.useless_gap,
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,
    }
end

helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end


helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl,
            radius)
    end
end

function helpers.colorize_text(txt, fg)
    return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

function helpers.maximize(c)
    c.maximized = not c.maximized
    if c.maximized then
        awful.placement.maximize(c, {
            honor_padding = true,
            honor_workarea = true,
            margins = beautiful.useless_gap * 2
        })
    end
    c:raise()
end

function helpers.round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end

function helpers.pad(size)
    local str = ""
    for i = 1, size do str = str .. " " end
    local pad = wibox.widget.textbox(str)
    return pad
end

return helpers
