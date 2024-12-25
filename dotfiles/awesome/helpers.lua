local helpers = {}

function helpers.bar_widget(widget)
    return Wibox.widget {
        {
            widget,
            top = Beautiful.useless_gap,
            bottom = Beautiful.useless_gap,
            right = Beautiful.useless_gap,
            widget = Wibox.container.margin,
        },
        widget = Wibox.container.background,
    }
end

helpers.rrect = function(radius)
    return function(cr, width, height)
        Gears.shape.rounded_rect(cr, width, height, radius)
    end
end


return helpers
