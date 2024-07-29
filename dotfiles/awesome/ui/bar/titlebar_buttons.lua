local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local clickable_container = require("modules.clickable-container")

local function sticky_button(c)
  return wibox.widget {
    {
      {
        awful.titlebar.widget.button(
          c,
          "Toggle the window sticking on all tags",
          function()
            if c.sticky then
              return "/home/emilia/.local/share/icons/unsticky.svg"
            end
            return "/home/emilia/.local/share/icons/sticky.svg"
          end,
          function ()
            c.sticky = not c.sticky
            c.ontop = c.sticky
          end
        ),
        widget = wibox.container.margin,
        margins = 2,
      },
      widget = clickable_container
    },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
  }
end

local function floating_button(c)
  return wibox.widget {
    {
      {
        awful.titlebar.widget.button(
          c,
          "Return to tiled layout",
          function()
            return "/home/emilia/.local/share/icons/tiles.svg"
          end,
          function ()
            c.floating = not c.floating
            if c.floating then
              awful.titlebar.show(c)
            else
              awful.titlebar.hide(c)
            end
          end
        ),
        widget = wibox.container.margin,
        margins = 2,
      },
      widget = clickable_container
    },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
  }
end

local function close_button(c)
  return wibox.widget {
    {
      {
        awful.titlebar.widget.button(
          c,
          "Close the window",
          function()
            return "/home/emilia/.local/share/icons/close.svg"
          end,
          function ()
            c:kill()
          end
        ),
        widget = wibox.container.margin,
        margins = 2,
      },
      widget = clickable_container
    },
    widget = wibox.container.background,
    shape = gears.shape.rounded_bar,
  }
end

return {
  sticky_button = sticky_button,
  floating_button = floating_button,
  close_button = close_button,
}
