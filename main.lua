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
    birds = {}

    table.insert(birds, Bird(love.math.random(0,windowWidth), 
                                love.math.random(0,windowHeight), 
                                10, 400))
    net = Net(0,0,0,0)
    tempNet = TempNet(500, 500, 90, 20)
    netTiles = {}
    squawk1 = love.audio.newSource("audio/bird-chirp1.mp3", "static")
    squawk1:setVolume(0.05)
    score = 0
    new_bird_cd = love.math.random(3,10)
    
    function collision_filter(item, other)
        if item:is(Player) and other:is(Bird) then return 
        elseif item:is(Player) and other:is(NetTile) then return
        elseif item:is(Player) and other:is(Tree) then return "slide"
        elseif item:is(Bird) and other:is(Bird) then return
        elseif item:is(Bird) and other:is(Tree) then return
        elseif item:is(Bird) and other:is(NetTile) then return "touch"
        end
    end
    -- Draw some trees randomly
    trees = {} 
    for i=1,20 do
        table.insert(trees, Tree(love.math.random(0,windowWidth), love.math.random(0,windowHeight), "small"))
    end

    love.graphics.setBackgroundColor(0.3,0.5,0.10)
end

function love.update(dt)
    for i,v in ipairs(birds) do
        v:update(dt)
    end
    player:update(dt)
    if player.placing_net then
        tempNet:update(dt)
    end
    if new_bird_cd <= 0 then
        table.insert(birds, Bird(love.math.random(0,windowWidth), 
                                    love.math.random(0,windowHeight), 
                                    10, 400))
        new_bird_cd = love.math.random(3,10)
    else
        new_bird_cd = new_bird_cd - dt
    end
end

function love.draw()
    cam:draw(function(l,t,w,h)
        player:draw()
        for i,v in ipairs(trees) do
            v:draw()
        end
        if #birds > 0 then
            for i,v in ipairs(birds) do
                v:draw()
            end
        end
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
    -- if key == "space" and any_trapped_bird and ((player.x - bird.x)^2 + (player.y - bird.y)^2)^0.5 < 200 then
    --     bird:captured()
    --     bird = Bird(love.math.random(0,windowWidth), 
    --             love.math.random(0,windowHeight), 
    --             10, 400)
    if key == "space" and not player.placing_net then
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