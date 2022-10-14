function gameplayDraw()
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