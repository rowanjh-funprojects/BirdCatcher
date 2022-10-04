local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"

    if launch_type == "debug" then
        lldebugger.start()
    end
end

function love.load()
    require "source/startup"
    -- Eventually package all startup into here
    startup()
    
    world = bump.newWorld()

    player = Player(100, 100, 300)
    bird = Bird(love.math.random(0,windowWidth), 
                love.math.random(0,windowHeight), 
                10, 400)
    net = Net(0,0,0,0)
    tempNet = TempNet(500, 500, 90, 20)
    netTiles = {}
    squawk1 = love.audio.newSource("audio/bird-chirp1.mp3", "static")
    score = 0
end

function love.update(dt)
    bird:update(dt)
    player:update(dt)
    if player.placing_net then
        tempNet:update(dt)
    end
end

function love.draw()
    cam:draw(function(l,t,w,h)
        player:draw()
        bird:draw()
        net:draw()
        tempNet:draw()
        if #netTiles > 0 then
            for i,v in ipairs(netTiles) do
                v:draw()
            end
        end
        love.graphics.print(score, 10, 10)
    end)
end

function love.keypressed(key)
    if key == "space" and bird.trapped and ((player.x - bird.x)^2 + (player.y - bird.y)^2)^0.5 < 200 then
        bird:captured()
        bird = Bird(love.math.random(0,windowWidth), 
                love.math.random(0,windowHeight), 
                10, 400)
    elseif key == "space" and not player.placing_net then
        tempNet = player:alignNet(20)
        player.placing_net = true
    elseif key == "space" and player.placing_net then
        -- kill old netTiles
        killOldNet()
        net, netTiles = tempNet:confirmNet()
        player.placing_net = false
    end
end

local love_errorhandler = love.errhand
function love.errorhandler(msg)
    if lldebugger then
        lldebugger.start() -- Add this
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end