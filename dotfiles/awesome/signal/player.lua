local awful = require("awful")

local update_interval = 1
local image_index = 1
local image = ""
local previous_image = ""
local ram_script = [[
  sh -c "
  (playerctl metadata mpris:artUrl; playerctl metadata title; playerctl metadata artist; playerctl metadata mpris:length; playerctl position) | tr '\n' '\t'
  "]]

local filename = ""
awful.widget.watch(ram_script, update_interval, function(widget, stdout)
  image = stdout:match('(.*)\t.*\t.*\t.*\t.*\t')
  if image == nil then
    return
  end
  if image ~= previous_image then
    image_index = image_index + 1
    filename = "/tmp/cover" .. tostring(image_index) .. ".jpg"
    awful.spawn.with_shell("rm /tmp/cover*.jpg")
    awful.spawn.with_shell("curl -o " .. filename .. " " .. image)
    previous_image = image
  end
  local title = stdout:match('.*\t(.*)\t.*\t.*\t.*\t')
  local artist = stdout:match('.*\t.*\t(.*)\t.*\t.*\t')
  local length = stdout:match('.*\t.*\t.*\t(.*)\t.*\t')
  local position = stdout:match('.*\t.*\t.*\t.*\t(.*)\t')
  length = tonumber(length) / 1000000
  position = tonumber(position)
  local progress = position / length * 100
  local minute = math.floor(position / 60)
  local second = math.floor(position % 60)
  local length_minute = math.floor(length / 60)
  local length_second = math.floor(length % 60)
  length = string.format("%02d:%02d", length_minute, length_second)
  position = string.format("%02d:%02d", minute, second)

  awesome.emit_signal("signal::player", filename, title, artist, length, position, progress)
end)
