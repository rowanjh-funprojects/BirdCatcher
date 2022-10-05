Player = Sprite:extend()

function Player:new(x, y, speed)
    Player.super.new(self, x, y)
    self.speed = speed
    self.placing_net = false

    -- Animations
    self.image = love.graphics.newImage("img/player_down walk.png")
    local nSpriteCols = 4
    local nSpriteRows = 2
    self.width = self.image:getWidth() / nSpriteCols
    self.height = self.image:getHeight() / nSpriteRows

    local g = anim8.newGrid(self.width, self.height, self.width * nSpriteCols, self.height * nSpriteRows)
    self.animation = anim8.newAnimation(g('1-4', 1), 0.1)
    world:add(self, self.x + self.width/4, self.y + self.height/4, self.width/2, self.height/2)
    
end

function Player:update(dt)
    local goalX = self.x
    local goalY = self.y
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        goalX = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d")  then
        goalX = self.x + self.speed * dt
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        goalY = self.y - self.speed * dt
    elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        goalY = self.y + self.speed * dt
    end

    -- Prevent player from going too far away from the temp net's origin point
    if self.placing_net then
        local new_dist = math.sqrt((goalY - tempNet.starty)^2 + (goalX - tempNet.startx)^2)
        if new_dist > tempNet.maxLength then
            local angle = math.atan2(goalY - tempNet.starty, goalX - tempNet.startx)
            local cos = math.cos(angle)
            local sin = math.sin(angle)
            goalX = tempNet.startx + cos * tempNet.maxLength
            goalY = tempNet.starty + sin * tempNet.maxLength
        end
    end
    self.x, self.y = world:move(self, goalX, goalY, collision_filter)
    self.animation:update(dt)
end
function Player:draw()
    -- love.graphics.draw(self.image, self.x, self.y)
    self.animation:draw(self.image, self.x, self.y)

end

function Player:alignNet(maxLength)
    return TempNet(player.x + player.width/2, player.y + player.height/2, 200, 200, maxLength)
end