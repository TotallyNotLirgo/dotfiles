local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local clickable_container = require("modules.clickable-container")


local function icon_button(icon, command)
  local widget = Helpers.bar_widget {
    {
      Wibox.widget.textbox("<span font='".. Font32 .. "' >" .. icon .. "</span>"),
      margins = dpi(6),
      widget = Wibox.container.margin,
    },
    widget = clickable_container,
    shape = Gears.shape.circle
  }
  widget:connect_signal(
    "button::press",
    function(_, _, _, button)
      if button == 1 then
        Awful.spawn(command)
      end
    end
  )
  return widget
end

local image = wibox.widget {
  image = AwesomeLocation .. "resources/icons/default-artwork.png",
  forced_height = 100,
  forced_width = 100,
  widget = wibox.widget.imagebox,
}
local title = wibox.widget.textbox('---')
local artist = wibox.widget.textbox('---')
local length = wibox.widget.textbox('0:00')
local position = wibox.widget.textbox('0:00')
local play_pause = icon_button('', 'playerctl play-pause')
local ratio = wibox.widget {
  bar_shape = gears.shape.rounded_rect,
  bar_height = 3,
  handle_shape = gears.shape.circle,
  handle_width = 10,
  handle_border_width = 1,
  value = 0,
  widget = wibox.widget.slider,
  forced_height = 10,
}
local control_pill = wibox.widget {
  {
    {
      icon_button('', 'playerctl previous'),
      play_pause,
      icon_button('', 'playerctl next'),
      spacing = dpi(10),
      layout = wibox.layout.fixed.horizontal,
    },
    margins = dpi(10),
    widget = wibox.container.margin,
  },
  widget = wibox.container.background,
  shape = gears.shape.rounded_bar,
  align = "center",
  forced_height = 60,
  forced_width = 160,
}

local popupWidget = wibox.widget {
  {
    {
      {
        image,
        wibox.widget {
          title,
          artist,
          layout = wibox.layout.flex.vertical
        },
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(10),
      },
      {
        position,
        {
          ratio,
          widget = wibox.container.margin,
          left = dpi(10),
          right = dpi(10),
        },
        length,
        layout = wibox.layout.align.horizontal
      },
      {
        {
          widget = control_pill,
          point = { x = 100, y = 0 },
        },
        layout = wibox.layout.manual,
      },
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(10),
    },
    widget = wibox.container.margin,
    margins = dpi(20),
  },
  resize = true,
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
  forced_height = 250,
  forced_width = 400,
}
awesome.connect_signal(
  'signal::player',
  function(i, t, a, l, p, r, s)
    if i == nil then
      return
    end
    image.image = i
    title.markup = "<b>" .. t .. "</b>"
    artist.markup = "<i>" .. a .. "</i>"
    length.text = l
    position.text = p
    ratio.value = r
    if s == "Playing" then
      play_pause.children[1].children[1].children[1].children[1].markup = "<span font='" .. Font32 .. "'></span>"
    else
      play_pause.children[1].children[1].children[1].children[1].markup = "<span font='" .. Font32 .. "'></span>"
    end
  end
)

local popup = awful.popup {
  ontop = true,
  visible = false,
  shape = gears.shape.rounded_rect,
  widget = popupWidget,
  border_width = beautiful.border_width,
  border_color = beautiful.border_color_active,
}
popupWidget:connect_signal(
  "mouse::leave",
  function()
    popup.visible = false
  end
)
return popup
