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
    require "source/userInput"
    require "source/helperFunctions"
    require "source/spawns"
    require "source/loadAudio"
    require "source/createEnvironment"
    
    -- Global parameters
    soundOn = true
    score = 0
    new_bird_cd = 5 -- cooldown for first new bird
    capture_range = 100
    tree_buffer = 50

    -- Game window config
    love.window.setTitle("Bird Catcher")
    local icon = love.image.newImageData('img/bird_static.png')
    love.window.setIcon(icon)

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


    -- Camera
    cam = gamera.new(0,0,2000,2000)

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

    -- Initialize entities
    player = Player(100, 100, 300)
    birds = {}
    table.insert(birds, Bird(love.math.random(0,windowWidth), 
                                love.math.random(0,windowHeight), 
                                10, 400))
    net = Net(0,0,0,0)
    tempNet = TempNet(500, 500, 90, 20)
    
    netTiles = {}

    -- Initialize environment
    createEnvironment()

    -- Load audio
    loadAudio()


end