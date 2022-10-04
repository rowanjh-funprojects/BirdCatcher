Player = Sprite:extend()

function Player:new(x, y, speed)
    Player.super.new(self, x, y, "img/player.png")
    self.speed = speed
    self.placing_net = false
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
    self.x, self.y = world:move(self, goalX, goalY)
end

function Player:alignNet(maxLength)
    return TempNet(player.x, player.y, 200, 200, maxLength)
end