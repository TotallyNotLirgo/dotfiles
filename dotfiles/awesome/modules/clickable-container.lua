local function build(widget)
  local container = Wibox.widget {
    widget,
    widget = Wibox.container.background
  }
  local old_cursor, old_wibox

  container:connect_signal(
    'mouse::enter',
    function()
      container.bg = Beautiful.foreground .. '11'
      ---@diagnostic disable-next-line: undefined-field
      local w = _G.mouse.current_wibox
      if w then
        old_cursor, old_wibox = w.cursor, w
        w.cursor = 'hand2'
      end
    end
  )

  container:connect_signal(
    'mouse::leave',
    function()
      container.bg = Beautiful.foreground .. '00'
      if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
      end
    end
  )
  container:connect_signal('button::press', function() container.bg = Beautiful.foreground .. '22' end)
  container:connect_signal('button::release', function() container.bg = Beautiful.foreground .. '11' end)

  return container
end

return build
