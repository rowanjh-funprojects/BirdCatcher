function startup()
    -- Global parameters
    soundOn = true
    capture_range = 100
    tree_buffer = 50
    bird_speed = 300
    player_speed = 200
    bird_scare_dist = 200
    bird_escape_time = {3,7}
    bird_lifespan = 60
    player_skill = 0.6
    player_frustration_increment = 0.1

    -- require all libraries
    Object = require "source/libraries/classic"
    bump = require "source/libraries/bump"
    anim8 = require "source/libraries/anim8"
    gamera = require "source/libraries/gamera"
    cron = require "source/libraries/cron"

    -- require all source files
    require "source/entities/entity"
    require "source/entities/sprite"
    require "source/entities/player"
    require "source/entities/bird"
    require "source/entities/birdSpecial"
    require "source/entities/birdPerching"
    require "source/entities/net"
    require "source/entities/tempNet"
    require "source/entities/tree"
    require "source/entities/treePerch"
    require "source/entities/spawner"
    require "source/entities/image"
    require "source/entities/text"
    require "source/entities/button"
    require "source/entities/panel"
    require "source/entities/worldEdge"
    require "source/userInput"
    require "source/helperFunctions"
    require "source/debugging"
    require "source/sound"
    require "source/loadAudio"
    require "source/maps"
    require "source/maps/createForest"
    require "source/maps/launchMenu"
    require "source/maps/roundEnd"
    
    -- Game window config
    love.window.setTitle("Bird Catcher")
    -- local icon = love.image.newImageData('img/bird_static.png')
    -- love.window.setIcon(icon)

    -- Resolution
    windowWidth = 1200
    windowHeight = 800
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

    -- update actual window size
    windowWidth = windowWidth * scale
    windowHeight = windowHeight * scale
    love.window.setMode(windowWidth, windowHeight, {fullscreen = false,
      fullscreentype = "desktop", resizable = false, borderless = false,
      vsync = true})

    -- Start physics engine, initialize world width/height for menu
    worldWidth = windowWidth
    worldHeight = windowHeight

    world = bump.newWorld()

    function collision_filter(item, other)
      if item:is(Player) and other:is(WorldEdge) then return "slide"
      elseif item:is(Player) and other:is(Tree) then return "slide"
      elseif item:is(Bird) and other:is(NetTile) then return "cross"
      end
    end
    
    -- Start Camera
    cam = gamera.new(0,0,worldWidth, worldHeight)

    -- Load audio
    loadAudio()
end