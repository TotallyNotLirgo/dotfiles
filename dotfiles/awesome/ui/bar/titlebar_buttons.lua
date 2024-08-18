local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local dracula = require("theme.colors")
local clickable_container = require("modules.clickable-container")

local icons_location = AwesomeLocation .. "resources/icons/"


local function sticky_button(c)
  return wibox.widget {
    {
      {
        awful.titlebar.widget.button(
          c,
          "",
          function()
            if c.sticky then
              return icons_location .. "unsticky.svg"
            end
            return icons_location .. "sticky.svg"
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
          "",
          function()
            return icons_location .. "maximize.svg"
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
          "",
          function()
            return icons_location .. "close.svg"
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
