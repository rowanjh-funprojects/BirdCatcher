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
    launchLevel(gamestate)



end

function love.update(dt)
    if gamestate == "menu" then
        if show_tutorial then
            for i = 1, #tutorial_elements do
                tutorial_elements[i]:update()
            end
        else
            for i=1,#buttons do
                buttons[i]:update()
            end
        end
    elseif gamestate == "forest" then
        cam:setPosition(player.x, player.y)

        timer:update(dt)
        -- Player update
        player:update(dt)
        if player.placing_net then
            tempNet:update(dt, player)
        end
        -- Bird update
        for i,v in ipairs(birds) do
            v:update(dt)
        end
        -- Tree update
        for i,v in ipairs(env.trees) do
            v:update(dt)
        end
        -- environment update
        for i,v in ipairs(env.bgElements) do
            v:update(dt)
        end
        -- Spawners update
        for i,v in ipairs(spawners) do
            v:update(dt)
        end

        remove_if_destroyed(birds)
        remove_if_destroyed(env.trees)
        remove_if_destroyed(env.bgElements)
        remove_if_destroyed(ui.textblocks)
        remove_if_destroyed(ui.panels)
        remove_if_destroyed(buttons)

        if seconds >= round_time then
            gamestate = "endround"
            launchLevel(gamestate)
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
        for i=1,#ui.panels do
            ui.panels[i]:draw()
        end
        for i=1,#buttons do
            buttons[i]:draw()
        end
        for i=1,#ui.textblocks do
            ui.textblocks[i]:draw()
        end
        if show_tutorial then
            for i = 1, #tutorial_elements do
                tutorial_elements[i]:draw()
            end
        end
    elseif gamestate == "forest" or gamestate == "endround" then

        cam:draw(function(l,t,w,h)
            -- Tilemap
            local nTilesWide = math.floor(params.worldWidth / tileset1.tile_width) + 1
            local nTilesHigh = math.floor(params.worldHeight / tileset1.tile_height) + 1
            for row=0, nTilesHigh do
                for col=0, nTilesWide do
                    love.graphics.draw(tileset1.tiles, col * tileset1.tile_width, row * tileset1.tile_height)
                end
            end
            
            for i,v in ipairs(env.bgElements) do
                v:draw()
            end
            for i,v in ipairs(env.bushes) do
                v:draw()
            end
            player:draw()

            for i,v in ipairs(env.rocks) do
                v:draw()
            end


            if net then
                net:draw()
            end

            if tempNet then
                tempNet:draw()
            end
            for i,v in ipairs(env.trees) do
                v:draw()
            end
            if #birds > 0 then
                for i,v in ipairs(birds) do
                    v:draw()
                end
            end
        end)
        love.graphics.print("Score: " .. score, 10, 10)
        love.graphics.print("Time Left: " .. round_time - seconds, 10, 25)
        love.graphics.print("High Score: " .. globals.high_score, params.winWidth/2, 10)
        if #ui.panels > 0 then
            for i,v in ipairs(ui.panels) do
                v:draw()
            end
        end
        if #ui.textblocks > 0 then
            for i,v in ipairs(ui.textblocks) do
                v:draw()
            end
        end
        if #buttons > 0 then
            for i,v in ipairs(buttons) do
                v:draw()
            end
        end

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