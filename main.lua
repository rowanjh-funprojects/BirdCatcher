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
    gamestate = "menu"
    launchMap(gamestate)
    seconds = 0
    timer = cron.every(1, function() seconds = seconds + 1 end)
end

function love.update(dt)
    if gamestate == "menu" then
        menu1:update()
        menu2:update()
        menu3:update()
    elseif gamestate == "forest" then
        timer:update(dt)
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
end

function love.draw()
    if gamestate == "menu" then
        love.graphics.print("BIRD CATCHER", 180, 50,0,10,10)
        menu1:draw()
        menu2:draw()
        menu3:draw()
    elseif gamestate == "forest" then
        cam:draw(function(l,t,w,h)
            -- Player drawing
            player:draw()
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
            -- Bird drawing
            if #birds > 0 then
                for i,v in ipairs(birds) do
                    v:draw()
                end
            end
        end)
        love.graphics.print("Score: " .. score, 10, 10)
        love.graphics.print("Time Left: " .. 60 - seconds, 10, 25)
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