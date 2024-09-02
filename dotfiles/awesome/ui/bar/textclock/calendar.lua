local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

awesome.register_xproperty("WM_CLASS", "string")

local styles = {}

styles.month = {
    padding = 5,
    fg_color = Beautiful.selection,
    markup = function(t) return t end,
}
local focus_style = {
    padding = 5,
    fg_color = Beautiful.purple,
    markup = function(t) return '<b>' .. t .. '</b>' end,
}
styles.focus = focus_style
styles.header = {
    fg_color = Beautiful.green,
    markup = function(t) return '<b>' .. t .. '</b>' end,
}
styles.weekday = {
    fg_color = Beautiful.foreground,
    markup = function(t) return '<b>' .. t .. '</b>' end,
}
local function decorate_cell(widget, flag)
    if flag == 'monthheader' and not styles.monthheader then flag = 'header' end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    return wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget = wibox.container.margin
        },
        fg = props.fg_color,
        widget = wibox.container.background
    }
end

local cal = wibox.widget {
    date = os.date('*t'),
    font = Beautiful.font,
    fn_embed = decorate_cell,
    widget = wibox.widget.calendar.month
}

local calWidget = wibox.widget {
    {
        cal,
        margins = dpi(8),
        widget = wibox.container.margin
    },
    resize = true,
    bg = beautiful.bg_normal,
    widget = wibox.container.background
}

local calendar = awful.popup {
    ontop = true,
    visible = false,
    shape = Gears.shape.rounded_rect,
    widget = calWidget,
    border_width = Beautiful.border_width,
    border_color = Beautiful.border_color_active,
}
calendar:connect_signal(
  "mouse::leave",
  function()
    calendar.visible = false
  end
)


local function set_date(date)
    local current_date = os.date('*t')
    if current_date.month == date.month and current_date.year == date.year then
        styles.focus = focus_style
    else
        styles.focus = styles.month
    end
    cal:set_date(nil)
    cal:set_date(date)
end

cal:buttons(
    awful.util.table.join(
        awful.button({}, 4, function()
            local a = cal:get_date()
            a.month = a.month + 1
            set_date(a)
        end),
        awful.button({}, 5, function()
            local a = cal:get_date()
            a.month = a.month - 1
            set_date(a)
        end)
    )
)
calendar:set_xproperty("WM_CLASS", "calendar")


local function cal_toggle(screen)
    calendar.visible = not calendar.visible
    calendar.x = screen.geometry.x + screen.geometry.width - 272
    calendar.y = screen.geometry.y + beautiful.wibar_height + beautiful.useless_gap * 2
end

return cal_toggle
