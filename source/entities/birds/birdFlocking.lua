BirdFlocking = BirdPerching:extend()

function BirdFlocking:new(x, y, sprite, speed, value, perchesOn)
    BirdFlocking.super.new(self, x, y, sprite, speed, value, perchesOn)
    self.flock = nil
    self.flockLeader = false
end

-- Try to join other flocking birds. Have a chance to pick their own destination occasionally.
function BirdFlocking:update(dt)
    BirdFlocking.super.update(self, dt)
    if self.scared then
        self:leaveFlock()
    end
end

function BirdFlocking:draw()
    BirdFlocking.super.draw(self)

    -- for debugging
    -- Flocking is a bit derpy, but I like how it plays out in the game.
    -- love.graphics.print(tostring(self.flockLeader), self.x, self.y)
    -- if self.flock then
    --     love.graphics.print(tostring(self.flock.flockid), self.x, self.y + 15)
    -- end
end

function BirdFlocking:destroy()
    BirdFlocking.super.destroy(self)
end

function BirdFlocking:selectNewDestination()
    -- Overwrite the base Bird selectNewDestination method (which is finding a random destination), don't inherit.
    if self.flock then
        if self.flockLeader then
            -- If a flock leader, find a new destination, take everyone with you, and 
            self:findNewPerch()
            self.flock:purgeTheDisbelievers()
            self.flock:musterTheRohirrem()
        else
            -- If a follower in a flock, then destination is pushed to the bird from the flock.
            return
        end
    else
        -- If not already in a flock,
        local prob = love.math.random(0,100) / 100
        if prob <= params.flock_join_prob then
            -- 80% chance to join a flock
            self:joinAFlock()
        else
            -- Join an existing flock, or else you are making your own flock
            self:makeFlock()
        end
    end
end

function BirdFlocking:joinAFlock()
    -- Join a random flock
    if #flocks > 0 then
        local randomChoice = love.math.random(1,#flocks)
        self.flock = flocks[randomChoice]
        table.insert(self.flock.followers, self)
        flocks[randomChoice].lonelyCurrentCD = params.flock_lonely_timer
        flocks[randomChoice]:musterTheRohirrem()
    else
        -- If there are no flocks, make a flock
        self:makeFlock()
    end
end

function BirdFlocking:makeFlock()
    self.flock = Flock(self)
    table.insert(flocks, self.flock)
    self:findNewPerch()
    self.flockLeader = true
end

function BirdFlocking:leaveFlock()
    self.flock = nil
    self.flockLeader = false
end