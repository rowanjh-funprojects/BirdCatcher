
function drawUI()
    if #images > 0 then
        for i=1,#images do
            images[i]:draw()
        end
    end
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
    if show_tutorial then
        for i = 1, #tutorial_elements do
            tutorial_elements[i]:draw()
        end
    end
end

-- spec'd as a gamera draw function
function drawGameplay(l,t,w,h)
    -- HUD
    love.graphics.setFont(fonts.regularText)
    love.graphics.print("Score: " .. score, 10, 10)
    love.graphics.print("Time Left: " .. round_time - seconds, 10, 25)
    love.graphics.print("High Score: " .. globals.high_score, params.gameWidth/2, 10)

    -- Tilemap
    local nTilesWide = math.floor(params.worldWidth / env.bgTiles.tile_width) + 1
    local nTilesHigh = math.floor(params.worldHeight / env.bgTiles.tile_height) + 1
    for row=0, nTilesHigh do
        for col=0, nTilesWide do
            love.graphics.draw(env.bgTiles.tiles, col * env.bgTiles.tile_width, row * env.bgTiles.tile_height)
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

    if #nets > 0 then
        for i,v in ipairs(nets) do
            v:draw()
        end
    end
    if netTemp then
        netTemp:draw()
    end
    for i,v in ipairs(env.trees) do
        v:draw()
    end
    if #birds > 0 then
        for i,v in ipairs(birds) do
            v:draw()
        end
    end
end

function drawGameGrid()
    love.graphics.setFont(fonts.regularText)
    for i=0, params.gameWidth, 100 do
        for j=0, params.gameHeight, 100 do
            if i == 0 then
                love.graphics.print('Height '..j, i, j)
            elseif j == 0 then
                love.graphics.print('Width '..i, i, j)
            else
                love.graphics.print('x', i, j)
            end
        end
    end
end

function drawWorldGrid()
    love.graphics.setFont(fonts.regularText)
    for i=0, params.worldWidth, 100 do
        for j=0, params.worldHeight, 100 do
            if i == 0 then
                love.graphics.print('Height '..j, i, j)
            elseif j == 0 then
                love.graphics.print('Width '..i, i, j)
            else
                love.graphics.print('o', i, j)
            end
        end
    end
end
