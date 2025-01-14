local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")

local header = wibox.widget.textbox("<span weight='bold'>Hardware:</span>")
local ram_widget = wibox.widget.textbox('')
local cpu_widget = wibox.widget.textbox('')
local disk_widget = wibox.widget.textbox('')
ram_widget.font = Font12
cpu_widget.font = Font12
disk_widget.font = Font12
local ram = 0
local cpu = 0
local disk = 0

local function wrap_icon(icon, color)
  if color == nil then
    color = Beautiful.foreground
  end
  return "<span font='FiraCode Nerd Font Mono 18' foreground='" .. color .. "'>" .. icon .. "</span>"
end

local function build_textbox()
  ram_widget.markup = wrap_icon("󰄨", Beautiful.blue) .. " " .. ram .. "GB "
  cpu_widget.markup = wrap_icon("󰍛", Beautiful.blue) .. " "  .. cpu .. "% "
  disk_widget.markup = wrap_icon("", Beautiful.blue) .. " "  .. disk .. "GB "
end

local compstats = wibox.widget {
  {
    {
      { widget = header, forced_height = dpi(30) },
      { widget = ram_widget, forced_height = dpi(30) },
      { widget = cpu_widget, forced_height = dpi(30) },
      { widget = disk_widget, forced_height = dpi(30) },
      layout = wibox.layout.fixed.vertical,
      spacing = Beautiful.useless_gap,
   },
    widget = wibox.container.margin,
    left = dpi(8),
    right = dpi(8),
    top = dpi(4),
    bottom = dpi(4),
  },
  widget = wibox.container.background,
  forced_width = dpi(200),
}
compstats:connect_signal(
  "button::press",
  function(_, _, _, button)
    if button == 1 then
      awful.spawn("kitty --class floater -e htop", {
        floating = true,
        ontop = true,
        placement = awful.placement.centered
      })
    end
  end
)
awesome.connect_signal(
  'signal::ram',
  function(used, _)
    ram = used
    build_textbox()
  end
)
awesome.connect_signal(
  'signal::cpu',
  function(used)
    cpu = used
    build_textbox()
  end
)
awesome.connect_signal(
  'signal::disk',
  function(used, _)
    disk = used
    build_textbox()
  end
)
return compstats
