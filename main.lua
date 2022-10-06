local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"

    if launch_type == "debug" then
        lldebugger.start()
    end
end

function love.load()
    require "source/startup"
    startup()
end

function love.update(dt)
    -- Player update
    player:update(dt)
    if player.placing_net then
        tempNet:update(dt)
    end
    -- Bird update
    for i,v in ipairs(birds) do
        v:update(dt)
    end
    remove_destroyed_items(birds)
    bird_spawner(dt)
end

function love.draw()
    cam:draw(function(l,t,w,h)
        -- Player drawing
        player:draw()
        -- Bird drawing
        if #birds > 0 then
            for i,v in ipairs(birds) do
                v:draw()
            end
        end
        -- Net drawing
        net:draw()
        tempNet:draw()
        if #netTiles > 0 then
            for i,v in ipairs(netTiles) do
                v:draw()
            end
        end
        -- Tree drawing
        for i,v in ipairs(trees) do
            v:draw()
        end

    end)
    love.graphics.print("Score: " .. score, 10, 10)

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