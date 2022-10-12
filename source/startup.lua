function startup()
    -- Global settings and parameters
    globals = {}
    globals.soundOn = true
    globals.high_score = 0

    params = {}
    params.capture_range = 100
    params.tree_buffer = 50
    params.player_speed = 200
    params.bird_speed = 300
    params.bird_scare_dist = 200
    params.bird_escape_time = {3,7}
    params.bird_lifespan = 60
    params.bird_spawn_rate = 8
    params.player_skill = 0.6
    params.player_frustration_increment = 0.1

    env = {}
    ui = {}
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
    require "source/entities/birds/bird"
    require "source/entities/birds/birdPerching"
    require "source/entities/equipment/net"
    require "source/entities/equipment/tempNet"
    require "source/entities/environment/envElement"
    require "source/entities/environment/tree"
    require "source/entities/environment/treePerch"
    require "source/entities/environment/worldEdge"
    require "source/entities/environment/pond"
    require "source/entities/environment/rock"
    require "source/entities/spawner"
    require "source/entities/ui/image"
    require "source/entities/ui/text"
    require "source/entities/ui/button"
    require "source/entities/ui/panel"
    require "source/userInput"
    require "source/helperFunctions"
    require "source/debugging"
    require "source/sound"
    require "source/loadAudio"
    require "source/loadSprites"
    require "source/launchLevel"
    require "source/maps/generateLevel"
    require "source/maps/launchMenu"
    require "source/maps/roundEnd"
    
    -- Game window config
    love.window.setTitle("Bird Catcher")
    -- local icon = love.image.newImageData('img/bird_static.png')
    -- love.window.setIcon(icon)

    -- Resolution
    local winWidth = 1200
    local winHeight = 800
    local scale = 1 -- adjusts game window to screen size
    local offset = 0.8 -- window size relative to scale
    local screen_width, screen_height = love.window.getDesktopDimensions()
    local w_scale = screen_width / winWidth
    local h_scale = screen_height / winHeight
    -- scale set to be the lesser of w_scale and h_scale so that window will not exceed screen size
    if w_scale < h_scale then
      scale = w_scale
    else
      scale = h_scale
    end
    scale = scale * offset

    -- update actual window size
    params.winWidth = winWidth * scale
    params.winHeight = winHeight * scale
    love.window.setMode(winWidth, winHeight, {fullscreen = false,
      fullscreentype = "desktop", resizable = false, borderless = false,
      vsync = true})

    -- Start physics engine, initialize world width/height for menu
    params.worldWidth = winWidth
    params.worldHeight = winHeight

    world = bump.newWorld()

    function collision_filter(item, other)
      if item:is(Player) and other:is(WorldEdge) then return "slide"
      elseif item:is(Player) and other:is(EnvElement) then return "slide"
      elseif item:is(Bird) and other:is(NetTile) then return "cross"
      end
    end
    
    -- Start Camera
    cam = gamera.new(0,0,params.worldWidth, params.worldHeight)

    -- Load audio
    loadAudio()
end