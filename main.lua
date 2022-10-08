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
    launchGamestate(gamestate)
end

function love.update(dt)
    if gamestate == "menu" then
        for i=1,#buttons do
            buttons[i]:update()
        end
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
        -- Tree update
        for i,v in ipairs(trees) do
            v:update(dt)
        end

        remove_if_destroyed(birds)
        remove_if_destroyed(trees)
        remove_if_destroyed(textblocks)
        remove_if_destroyed(panels)
        remove_if_destroyed(buttons)
        bird_spawner(dt)
        if seconds >= round_time then
            gamestate = "endround"
            launchGamestate(gamestate)
        end
    elseif gamestate == "endround" then
        -- Buttons update
        for i,v in ipairs(buttons) do
            v:update(dt)
        end
    end
end

function love.draw()
    if gamestate == "menu" then
        for i=1,#images do
            images[i]:draw()
        end
        for i=1,#panels do
            panels[i]:draw()
        end
        for i=1,#buttons do
            buttons[i]:draw()
        end
        for i=1,#textblocks do
            textblocks[i]:draw()
        end

    elseif gamestate == "forest" or gamestate == "endround" then
        cam:draw(function(l,t,w,h)
            player:draw()
            if net then
                net:draw()
            end

            if tempNet then
                tempNet:draw()
            end

            for i,v in ipairs(trees) do
                v:draw()
            end
            if #birds > 0 then
                for i,v in ipairs(birds) do
                    v:draw()
                end
            end
            if #panels > 0 then
                for i,v in ipairs(panels) do
                    v:draw()
                end
            end
            if #textblocks > 0 then
                for i,v in ipairs(textblocks) do
                    v:draw()
                end
            end
            if #buttons > 0 then
                for i,v in ipairs(buttons) do
                    v:draw()
                end
            end
        end)
        love.graphics.print("Score: " .. score, 10, 10)
        love.graphics.print("Time Left: " .. round_time - seconds, 10, 25)
    end
    -- drawDebugGrid()
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