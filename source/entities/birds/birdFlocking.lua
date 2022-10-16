BirdFlocking = BirdPerching:extend()

function BirdFlocking:new(x, y, sprite, speed, value, perchesOn)
    BirdFlocking.super.new(self, x, y, sprite, speed, value, perchesOn)
end

-- Try to join other flocking birds. Have a chance to pick their own destination occasionally.
function BirdFlocking:update(dt)
    BirdFlocking.super.update(self, dt)
end

function BirdFlocking:draw()
    BirdFlocking.super.draw(self)
end

function BirdFlocking:destroy()
    BirdFlocking.super.destroy(self)
end

function BirdFlocking:selectNewDestination()
    -- Overwrite the base Bird selectNewDestination method (which is finding a random destination), don't inherit.

    -- Find a flock to join. Small chance of creating their own flock. 
    local prob = love.math.random(0,100) / 100
    if prob >= 0.3 then
        self:findFlock()
    else
        self:makeFlock()
    end
end

function BirdFlocking:findFlock()

end

function BirdFlocking:makeFlock()

end