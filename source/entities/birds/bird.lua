Bird = Sprite:extend()

function Bird:new(x, y, speed, value)
    Bird.super.new(self, x, y)

    -- Bird parameters
    self.value = value
    self.speed = speed

    -- Bird state
    self.target_x = x
    self.target_y = y
    self.patience = 0
    self.escapetime = 0
    self.trapped = false
    self.scared_dist = bird_scare_dist
    self.scared_timer = 1
    self.invincible_timer = 0
    self.destroyed = false
    self.lifespan = bird_lifespan
    self.emigrating = false -- Bird still wants to stay in the world

    -- Default sprite and animation
    if not self.image then
        self.image = sprites.birds.generic
        local nSpriteCols = 3
        local nSpriteRows = 3
        self.spriteWidth = math.floor(self.image:getWidth() / nSpriteCols)
        self.spriteHeight = math.floor(self.image:getHeight() / nSpriteRows)
        local g = anim8.newGrid(self.spriteWidth, self.spriteHeight, 
                                self.spriteWidth * nSpriteCols, self.spriteHeight * nSpriteRows)
        self.animation = anim8.newAnimation(g('1-3','1-3'), 0.1)
        
    end

    -- drawing offsets
    self.drawOffsetX = self.spriteWidth / 2
    self.y_drawoffset = self.spriteHeight / 2
    
    -- Setup collision rectangle.
    self.boxWidth = math.floor(self.spriteWidth / 2)
    self.boxHeight = math.floor(self.spriteHeight / 2)
    self.boxOffsetX = self.boxWidth / 2
    self.boxOffsetY = self.boxHeight / 2

    world:add(self, self.x - self.boxOffsetX, self.y - self.boxOffsetY, self.boxWidth, self.boxHeight)
end

function Bird:update(dt)
    Bird.super.update(self, dt)
    if self.trapped then
        if self.escapetime > 0 then
            self.escapetime = self.escapetime - 1*dt
        else
            self:gotFree()
        end
    -- If the bird is emigrating
    elseif self.emigrating then
        if self:isOffscreen() then
            self:destroy()
        else
            self:moveTowardsDestination(dt)
        end
    -- If bird is free and too close to the player, get scared away
    elseif get_dist_objs(player, self) <= self.scared_dist then
        if self.scared_timer <= 0 then
            self:scaredAway()
        end
        if get_dist_points(self.x, self.y, self.target_x, self.target_y) >= 30 then
            self:moveTowardsDestination(dt)
        end
    -- If not trapped, and not yet at destination
    elseif get_dist_points(self.x, self.y, self.target_x, self.target_y) >= 30 then
        self:moveTowardsDestination(dt)
    -- If at destination, wait until patience runs out, and find new destination
    else
        if self.patience > 0 then
            self.patience = self.patience - dt
        else
            self:selectNewDestination()
            self.patience = love.math.random(1, 4)
        end
    end 
    if self.invincible_timer > 0 then
        self.invincible_timer = self.invincible_timer - dt
    end
    if self.scared_timer > 0 then
        self.scared_timer = self.scared_timer - dt
    end
    if self.lifespan <= 0 and not self.emigrating then
        self:emigrate() -- fly away from the world
    else
        self.lifespan = self.lifespan - dt
    end
    self.animation:update(dt)
end

function Bird:draw()
    Bird.super.draw(self)
    if self.trapped then
        -- Add halo if trapped
        love.graphics.setColor(1,0.95,0,0.3)
        love.graphics.circle("fill", self.x, self.y, self.spriteWidth * 0.4)
        love.graphics.circle("fill", self.x, self.y, self.spriteWidth * 0.3)
        love.graphics.circle("fill", self.x, self.y, self.spriteWidth * 0.2)
        love.graphics.setColor(1,1,1,1)
    end

    -- Draw bird, with bbox offset
    if self.invincible_timer > 0 then
        love.graphics.setColor(1,1,1,0.75)
    end
    self.animation:draw(self.image, self.x - self.drawOffsetX, self.y - self.y_drawoffset)
    love.graphics.setColor(1,1,1,1)
    
    -- -- draw target for debugging
    -- love.graphics.setColor(1,1,1,0.8)
    -- love.graphics.circle("fill", self.target_x, self.target_y, 3)
    -- love.graphics.setColor(1,1,1,1)
end

function Bird:emigrate()
    self.emigrating = true
    self.patience = 0
    -- pick a random destination around the edge of the map
    -- choose an edge, top, bot, left, or right
    local edge = love.math.random(1,4)
    if edge == 1 then -- top
        self.target_x = love.math.random(0,worldWidth)
        self.target_y = self.spriteHeight*-1 - 100
    elseif edge == 2 then --right
        self.target_x = worldWidth + 100
        self.target_y = love.math.random(0,worldHeight)
    elseif edge == 3 then --bottom
        self.target_x = love.math.random(0,worldWidth)
        self.target_y = worldHeight + 100
    else --left
        self.target_x = self.spriteWidth*-1 - 100
        self.target_y = love.math.random(0,worldHeight)
    end
end

function Bird:destroy()
    Bird.super.destroy(self)
end

function Bird:moveTowardsDestination(dt)
    -- Transform to bbox coordinates
    local currentX = self.x - self.boxOffsetX
    local currentY = self.y - self.boxOffsetY
    local goalX = self.target_x - self.boxOffsetX
    local goalY = self.target_y - self.boxOffsetY

    -- Work out angle of trajectory
    local angle = math.atan2(goalY - currentY, goalX - currentX)
    local cos = math.cos(angle)
    local sin = math.sin(angle)
    local cols, len

    -- Move in straight line towards destination point
    local resultingX, resultingY
    resultingX, resultingY, cols, len = world:move(self, 
        currentX + self.speed * cos * dt, 
        currentY + self.speed * sin * dt,
        collision_filter)
    if len > 0 then
        if cols[1].other:is(NetTile) then
            if self.invincible_timer <= 0 then
                self:gotTrapped()
            end
        end
    end
    -- Transform back to original coordinates
    self.x = resultingX + self.boxOffsetX
    self.y = resultingY + self.boxOffsetY
end

-- pick a random spot on the map
function Bird:selectNewDestination()
    self:findRandomDestination()
end

function Bird:findRandomDestination()
    self.target_x = love.math.random(0, windowWidth - self.spriteWidth)
    self.target_y = love.math.random(0, windowHeight - self.spriteHeight)
end

-- pick a spot in the opposite direction from the player
function Bird:findSafeDestination()
    local angle = math.atan2(player.y - self.y, player.x - self.x)
    local cos = math.cos(angle)
    local sin = math.sin(angle)
    self.target_x = self.x + love.math.random(200, 500) * (cos + love.math.random(-1, 1)) * -1
    self.target_y = self.y + love.math.random(200, 500) * (sin + love.math.random(-1, 1)) * -1
end


function Bird:scaredAway()
    self.scared_timer = 1 -- won't be scared again too fast
    self.patience = 0 -- find a new destination as soon as it reaches it safe destination
    self:findSafeDestination()
end


function Bird:gotTrapped()
    self.trapped = true
    self.escapetime = love.math.random(bird_escape_time[1], bird_escape_time[2])
    self:chirp("gotTrapped")
end

function Bird:captured()
    self:destroy()
end

function Bird:gotFree()
    self.trapped = false
    self.patience = 0
    self.invincible_timer = 2
    self:findSafeDestination()
    self:talk("Escaped", 2)
    self:chirp("gotFree")
    escaped_birds = escaped_birds + 1
end

function Bird:chirp(type)
    if soundOn then
        if type == "gotTrapped" then
            chirp_2:play()
        elseif type == "gotFree" then
            chirp_3:play()
        end
    end
end
