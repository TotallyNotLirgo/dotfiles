local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local clickable_container = require("modules.clickable-container")

local icons_location = AwesomeLocation .. "resources/icons/"

local Button = {}

function Button:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Button:get_widget(c)
  self.c = c
  return wibox.widget {
    {
      {
        awful.titlebar.widget.button(
          c, "",
          function() return self:get_icon() end,
          function() self:on_click() end
        ),
        widget = wibox.container.margin,
        margins = 2,
      },
      widget = clickable_container,
    },
    widget = wibox.container.background,
    shape = gears.shape.rounded_bar,
  }
end

function Button:on_click()
end

function Button:get_icon()
end

----------------------

local StickyButton = Button:new()

function StickyButton:on_click()
  self.c.sticky = not self.c.sticky
  self.c.ontop = self.c.sticky
end

function StickyButton:get_icon()
  return icons_location .. (self.c.sticky and "unsticky.svg" or "sticky.svg")
end

----------------------

local FloatingButton = Button:new()

function FloatingButton:on_click()
  self.c.floating = false
  self.c.maximized = false
  self.c.fullscreen = false
  awful.titlebar.hide(self.c)
end

function FloatingButton:get_icon()
  return icons_location .. "maximize.svg"
end

----------------------

local CloseButton = Button:new()

function CloseButton:on_click()
  self.c:kill()
end

function CloseButton:get_icon()
  return icons_location .. "close.svg"
end

----------------------

return {
  StickyButton = StickyButton,
  FloatingButton = FloatingButton,
  CloseButton = CloseButton,
}
