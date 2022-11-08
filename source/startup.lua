function startup()
    -- Global settings and parameters
    globals = {}
    globals.soundOn = true
    globals.high_score = 0
    globals.paused = false

    params = {}
    params.capture_range = 100
    params.tp_countdown = 2
    params.tree_buffer = 50
    params.bird_speed = 300
    params.bird_scare_dist = 200
    params.bird_escape_time = {5,10}
    params.bird_lifespan = 60
    params.bird_spawn_rate = 15 -- How many seconds between spawns
    params.player_skill = 0.6
    params.player_frustration_increment = 0.1
    params.player_quiet_cooldown = 3
    params.player_extract_duration = 1.5
    params.player_speed = 250
    params.player_nets_allowed = 2
    params.net_max_length = 200

    params.flock_join_prob = 0.8 -- Prob of joining a flock rather then making a new flock if not already in a flock
    params.flock_loyalty = 0.9 -- Prob that a bird will stay with a flock and not leave it every time the flock moves
    params.flock_lonely_timer = 2 -- how long before a solo bird gives up on their flock and joins another one


    style = {}
    style.buttonCol = {0.96,0.87,0.70, 0.8}
    style.txtCol = {0,0,0}

    env = {}
    ui = {}
    -- require all libraries
    Object = require "source/libraries/classic"
    bump = require "source/libraries/bump"
    anim8 = require "source/libraries/anim8"
    gamera = require "source/libraries/gamera"
    cron = require "source/libraries/cron"
    push = require "source/libraries/push"

    -- require all source files
    require "source/entities/entity"
    require "source/entities/sprite"
    require "source/entities/player"
    require "source/entities/birds/bird"
    require "source/entities/birds/birdPerching"
    require "source/entities/birds/birdFlocking"
    require "source/entities/birds/flock"
    require "source/entities/equipment/net"
    require "source/entities/equipment/netPlaced"
    require "source/entities/equipment/netTemp"
    require "source/entities/equipment/netTiles"
    require "source/entities/environment/envElement"
    require "source/entities/environment/tree"
    require "source/entities/environment/treePerch"
    require "source/entities/environment/worldEdge"
    require "source/entities/environment/pond"
    require "source/entities/environment/rock"
    require "source/entities/environment/bush"
    require "source/entities/spawner"
    require "source/entities/ui/image"
    require "source/entities/ui/text"
    require "source/entities/ui/button"
    require "source/entities/ui/panel"
    require "source/userInput"
    require "source/helperFunctions"
    require "source/sound"
    require "source/loadAudio"
    require "source/loadGraphics"
    require "source/loadFonts"
    require "source/launchLevel"
    require "source/maps/generateLevel"
    require "source/maps/launchMenu"
    require "source/maps/roundEnd"
    require "source/maps/pauseScreen"
    require "source/gameplayUpdate"
    require "source/gameplayDraw"
    -- Game window config
    love.window.setTitle("Bird Catcher")
    -- local icon = love.image.newImageData('img/bird_static.png')
    -- love.window.setIcon(icon)

    -- Base game resolution
    params.gameWidth = 1440
    params.gameHeight = 810

    local scale = 1 -- adjusts game window to screen size
    local offset = 0.8 -- window size relative to screen size
    local screen_width, screen_height = love.window.getDesktopDimensions()
    local w_scale = screen_width / params.gameWidth
    local h_scale = screen_height / params.gameHeight
    -- scale set to be the lesser of w_scale and h_scale so that window will not exceed screen size
    if w_scale < h_scale then
      scale = w_scale
    else
      scale = h_scale
    end
    params.gameScale = scale * offset

    -- get window size in pixels
    params.windowWidth = params.gameWidth * params.gameScale
    params.windowHeight = params.gameHeight * params.gameScale

    -- setup push to handle scaling to different window sizes and resolutions
    push:setupScreen(params.gameWidth, params.gameHeight, params.windowWidth, params.windowHeight,
      {fullscreen = false, resizable = true, canvas = true, pixelperfect = false})

    -- love.window.setMode(params.windowWidth, params.windowHeight, {fullscreen = false,
    --   fullscreentype = "desktop", resizable = false, borderless = false,
    --   vsync = true})

    -- Start physics engine
    world = bump.newWorld()

    -- prepare collision filter for bump
    function collision_filter(item, other)
      if item:is(Player) and other:is(WorldEdge) then return "slide"
      elseif item:is(Player) and other:is(EnvElement) then return "slide"
      elseif item:is(Bird) and other:is(NetTile) then return "cross"
      end
    end
    
    -- Start Camera, initialize world size to gameWidth.
    cam = gamera.new(0,0,params.gameWidth, params.gameHeight)
    -- cam:setScale(params.gameScale)
    -- Load audio
    loadAudio()
    loadFonts()
    loadSprites()
end