function drawDebugGrid()
    for i=0, windowWidth, 100 do
        for j=0, windowHeight, 100 do
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