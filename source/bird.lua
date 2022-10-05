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
    self.destroyed = false

    -- Animations
    self.image = love.graphics.newImage("img/bird2blue_0.10_fixed.png")
    self.width = math.floor(self.image:getWidth() / 3)
    self.height = math.floor(self.image:getHeight() / 3)

    local g = anim8.newGrid(self.width, self.height, self.width * 3, self.height * 3)
    self.animation = anim8.newAnimation(g('1-3','1-3'), 0.1)
    world:add(self, self.x + self.width/4, self.y + self.height/4, self.width/2, self.height/2)

    -- self.scare_timer = 2
end

function Bird:update(dt)
    if self.destroyed then
        world:remove(self)
    end
    local near_destination = math.abs(self.x - self.target_x) <= 20 and math.abs(self.y - self.target_y) <= 20
    if self.trapped then
        if self.escapetime > 0 then
            self.escapetime = self.escapetime - 1*dt
        else
            self:gotFree()
        end
    -- if the bird is too close to the player, try to get away
    elseif ((player.x - self.x)^2 + (player.y - self.y)^2)^0.5 <= self.scared_dist then
        self:findSafeDestination(dt)
        self:flyTowardsDestination(dt)
-- If the bird is free, and not at its destination, the player isn't nearby, move towards the destination
    elseif math.abs(self.x - self.target_x) >= 20 and math.abs(self.y - self.target_y) >= 20 then
        self:flyTowardsDestination(dt)
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

-- Bird flight movements (dipping up and down a little) shall be handled with draw?
function Bird:draw()
    if self.destroyed then
        return
    end
    -- Draw bird
    self.animation:draw(self.image, self.x, self.y)
    --Draw box
    Bird.super.draw(self)

    -- Draw speech messages
    if self.trapped then
        love.graphics.print("SKUAWK (I'm Trapped!)", self.x, self.y)
    elseif self.gloat_timer > 0 then
        love.graphics.print("I'm FREE sucker!", self.x, self.y)
    end
end
function Bird:flyTowardsDestination(dt)
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
    self:squawk()
end

function Bird:captured()
    self.destroyed = true
    score = score + 1
end

function Bird:gotFree()
    self.trapped = false
    self.patience = 0
    self.gloat_timer = 2
    self.invincible_timer = 2
    self:findRandomDestination()
    self:squawk()
end

function Bird:squawk()
    if soundOn then
        squawk1:play()
    end
end
