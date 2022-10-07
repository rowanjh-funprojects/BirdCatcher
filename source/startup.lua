function startup()
    -- require all libraries
    Object = require "source/libraries/classic"
    bump = require "source/libraries/bump"
    anim8 = require "source/libraries/anim8"
    gamera = require "source/libraries/gamera"
    cron = require "source/libraries/cron"

    -- require all source files
    require "source/entities/entity"
    require "source/entities/sprite"
    require "source/entities/bird"
    require "source/entities/player"
    require "source/entities/net"
    require "source/entities/tempNet"
    require "source/entities/tree"
    require "source/entities/button"
    require "source/entities/panel"
    require "source/entities/text"
    require "source/userInput"
    require "source/helperFunctions"
    require "source/spawns"
    require "source/loadAudio"
    require "source/maps/createForest"
    require "source/maps"
    require "source/maps/launchMenu"
    
    -- Global parameters
    soundOn = true
    score = 0
    new_bird_cd = 1 -- cooldown for first new bird
    capture_range = 100
    tree_buffer = 50
    bird_speed = 300

    -- Game window config
    love.window.setTitle("Bird Catcher")
    -- local icon = love.image.newImageData('img/bird_static.png')
    -- love.window.setIcon(icon)

    -- Resolution
    windowWidth = 1152
    windowHeight = 768
    local scale = 1 -- adjusts game window to screen size
    local offset = 0.8 -- window size relative to scale
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


    -- Start physics engine
    world = bump.newWorld()
    function collision_filter(item, other)
      if item:is(Player) and other:is(Bird) then return 
      elseif item:is(Player) and other:is(NetTile) then return
      elseif item:is(Player) and other:is(Tree) then return "slide"
      elseif item:is(Bird) and other:is(Bird) then return
      elseif item:is(Bird) and other:is(Tree) then return
      elseif item:is(Bird) and other:is(NetTile) then return "touch"
      end
    end
    -- Camera
    cam = gamera.new(0,0,2000,2000)

    -- Load audio
    loadAudio()
end