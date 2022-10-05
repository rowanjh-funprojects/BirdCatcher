function startup()
    -- require all libraries
    Object = require "source/libraries/classic"
    bump = require "source/libraries/bump"
    anim8 = require "source/libraries/anim8"
    gamera = require "source/libraries/gamera"

    -- require all source files
    require "source/sprite"
    require "source/bird"
    require "source/player"
    require "source/net"
    require "source/tempNet"
    require "source/tree"

    -- Game window config
    love.window.setTitle("Bird Catcher")
    local icon = love.image.newImageData('img/bird_static.png')
    love.window.setIcon(icon)
    -- Resolution
    windowWidth = 1152
    windowHeight = 768
    scale = 1 -- adjusts game window to screen size
    offset = 0.8 -- window size relative to scale
    local screen_width, screen_height = love.window.getDesktopDimensions()
    local w_scale = screen_width / windowWidth
    local h_scale = screen_height / windowHeight
    -- scale set to be the lesser of w_scale and h_scale so that window will not exceed screen size
    if w_scale < h_scale then
      scale = w_scale
    else
      scale = h_scale
    end
    scale = scale * offset
    love.window.setMode(windowWidth * scale, windowHeight * scale, {fullscreen = false,
      fullscreentype = "desktop", resizable = false, borderless = false,
      vsync = true})

    -- Sound control global variable
    soundOn = true

    -- Camera
    cam = gamera.new(0,0,2000,2000)

end