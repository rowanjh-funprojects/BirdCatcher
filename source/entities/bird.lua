Bird = Sprite:extend()

function Bird:new(x, y, value, speed)
    Bird.super.new(self, x, y)
    self.value = value
    self.speed = speed
    self.target_x = 500
    self.target_y = 500
    self.patience = love.math.random(1, 4) -- How long the bird will wait in one spot
    self.escapetime = love.math.random(3, 10)
    self.trapped = false
    self.gloat_timer = 0
    self.scared_dist = 150
    self.invincible_timer = 2
    self.panic_timer = 1
    self.destroyed = false

    -- Animations
    self.image = love.graphics.newImage("img/bird2blue_0.10_fixed.png")
    self.spriteWidth = math.floor(self.image:getWidth() / 3)
    self.spriteHeight = math.floor(self.image:getHeight() / 3)
    local g = anim8.newGrid(self.spriteWidth, self.spriteHeight, 
                            self.spriteWidth * 3, self.spriteHeight * 3)
    self.animation = anim8.newAnimation(g('1-3','1-3'), 0.1)

    -- Setup collision rectangle. This is the authoritative position of the bird. 
    -- The drawing animation then needs to be offset so that the middle of the 
    -- sprite drawing matches the middle of the collision rect.
    self.width = self.spriteWidth / 2
    self.height = self.spriteHeight / 2
    world:add(self, self.x, self.y, self.width, self.height)
end

function Bird:update(dt)
    Bird.super.update(self)
    if self.trapped then
        if self.escapetime > 0 then
            self.escapetime = self.escapetime - 1*dt
        else
            self:gotFree()
        end
    -- if the bird is too close to the player, try to get away
    elseif get_dist_objs(player, self) <= self.scared_dist then
        self:findSafeDestination(dt)
        self:moveTowardsDestination(dt)
-- If the bird is free, and not at its destination, the player isn't nearby, move towards the destination
    elseif get_dist_points(self.x, self.y, self.target_x, self.target_y) >= 60 then
        self:moveTowardsDestination(dt)
    else
        -- If bird is chilling at its destination, it will be patient until it gets bored and finds new destination
        if self.patience > 0 then
            self.patience = self.patience - dt
        else
            self:findRandomDestination()
            self.patience = love.math.random(1, 4)
        end
    end 
    if self.gloat_timer > 0 then
        self.gloat_timer = self.gloat_timer - dt
    end
    if self.invincible_timer > 0 then
        self.invincible_timer = self.invincible_timer - dt
    end
    self.animation:update(dt)
end

function Bird:draw()
    Bird.super.draw(self)

    if self.trapped then
        -- Add halo if trapped
        love.graphics.setColor(255,223,0,0.3)
        love.graphics.circle("fill", self.x + self.width/2, self.y + self.height/2, self.width * 0.8)
        love.graphics.circle("fill", self.x + self.width/2, self.y + self.height/2, self.width * 0.6)
        love.graphics.circle("fill", self.x + self.width/2, self.y + self.height/2, self.width * 0.3)
        love.graphics.setColor(1,1,1,1)

    elseif self.gloat_timer > 0 then
        love.graphics.print("I'm FREE!", self.x, self.y)
    end

    -- Draw bird, with bbox offset
    local xSpriteOffset = (self.spriteWidth - self.width) / 2
    local ySpriteOffset = (self.spriteHeight - self.height) / 2
    self.animation:draw(self.image, self.x - xSpriteOffset, self.y - ySpriteOffset)
end

function Bird:destroy()
    Bird.super.destroy(self)
    world:remove(self)
end

function Bird:moveTowardsDestination(dt)
    local angle = math.atan2(self.target_y - self.y, self.target_x - self.x)
    local cos = math.cos(angle)
    local sin = math.sin(angle)
    self.x, self.y, cols, len = world:move(self, 
        self.x + self.speed * cos * dt, 
        self.y + self.speed * sin * dt,
        collision_filter)
    if len > 0 then
        if cols[1].other:is(NetTile) then
            if self.invincible_timer <= 0 then
                self:gotTrapped()
            end
        end
    end
end

-- pick a random spot on the map
function Bird:findRandomDestination()
    self.target_x = love.math.random(0, windowWidth - self.width)
    self.target_y = love.math.random(0, windowHeight - self.height)
end

-- pick a spot in the opposite direction from the player
function Bird:findSafeDestination()
    local angle = math.atan2(player.y - self.y, player.x - self.x)
    local cos = math.cos(angle)
    local sin = math.sin(angle)
    self.target_x = self.x + love.math.random(200, 500) * (cos + love.math.random(-1, 1)) * -1
    self.target_y = self.y + love.math.random(200, 500) * (sin + love.math.random(-1, 1)) * -1
end

function Bird:gotTrapped()
    self.trapped = true
    self.escapetime = love.math.random(3, 10)
    self:chirp("trapped")
end

function Bird:captured()
    self:destroy()
end

function Bird:gotFree()
    self.trapped = false
    self.patience = 0
    self.gloat_timer = 2
    self.invincible_timer = 2
    self:findRandomDestination()
    self:chirp("gotFree")
end

function Bird:chirp(type)
    if soundOn then
        if type == "trapped" then
            chirp_2:play()
        elseif type == "gotFree" then
            chirp_3:play()
        end
    end
end
