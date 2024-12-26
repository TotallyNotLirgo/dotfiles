screen.connect_signal("request::wallpaper", function(s)
    if Beautiful.wallpaper then
        local wallpaper = Beautiful.wallpaper
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        Gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
