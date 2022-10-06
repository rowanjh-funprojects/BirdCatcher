function bird_spawner(dt)
-- New bird spawning
    if new_bird_cd <= 0 then
        table.insert(birds, Bird(love.math.random(0,windowWidth), 
                                    love.math.random(0,windowHeight), 
                                    10, 400))
        new_bird_cd = love.math.random(3,10)
    else
        new_bird_cd = new_bird_cd - dt
    end
end