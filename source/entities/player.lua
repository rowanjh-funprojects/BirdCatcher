Player = Sprite:extend()

function Player:new(x, y, speed)
    Player.super.new(self, x, y)
    self.speed = player_speed
    self.placing_net = false
    self.quiet = false
    self.quiettimer = 5
    self.skill = 0.6
    self.speaktimer = 0
    
    -- Animations
    self.image = love.graphics.newImage("img/player_down walk.png")
    local nSpriteCols = 4
    local nSpriteRows = 2
    self.width = self.image:getWidth() / nSpriteCols
    self.height = self.image:getHeight() / nSpriteRows
    local g = anim8.newGrid(self.width, self.height, self.width * nSpriteCols, self.height * nSpriteRows)
    self.animation = anim8.newAnimation(g('1-4', 1), 0.1)

    -- Setup collision rectangle
    self.bbox_x_offset = self.width / 4
    self.bbox_y_offset = self.height / 4
    self.bbox_width = self.width / 2
    self.bbox_height = self.height / 2
    world:add(self, self.x, self.y, self.bbox_width, self.bbox_height)
end

function Player:update(dt)
    Player.super.update(self, dt)
    -- Manage player movements
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
    self.x, self.y, cols, len = world:move(self, goalX, goalY, collision_filter)

    self.animation:update(dt)
end

function Player:draw()
    Player.super.draw(self)
    self.animation:draw(self.image, self.x - self.bbox_x_offset, self.y - self.bbox_y_offset)
end

function Player:alignNet(maxLength)
    self.placing_net = true
    return TempNet(self.x + self.width/2 - self.bbox_x_offset, self.y + self.height / 2 - self.bbox_y_offset, 200, 200, maxLength)
end

function Player:check_bird_captures()
    local any_birds_capturable = false
    local closest_dist = -1
    local nearest_bird = nil
    for i,v in ipairs(birds) do
        if v.trapped == true then
            local distance = get_dist_objs(self, v)
            if distance <= capture_range then
                any_birds_capturable = true
                if closest_dist == -1 or distance < closest_dist then
                    closest_dist = distance
                    nearest_bird = v
                end
            end
        end
    end
    return any_birds_capturable, nearest_bird
end

function Player:tryToExtractBird(thisbird)
    if player:extractSkillCheck() then
        thisbird:captured()
        if thisbird.value <= 10 then
            bell:play()
        elseif thisbird.value >10 then
            bellMulti:play()
        end
        score = score + thisbird.value
        player:talk("+"..thisbird.value, 1)
        captured_birds = captured_birds + 1
    else
        thisbird:gotFree()
    end
end

function Player:extractSkillCheck()
    if love.math.random(0,1) >= player.skill then
        return true
    else 
        player:talk("doh", 2)
        failed_extractions = failed_extractions + 1
    end
end

function Player:destroy()
    Player.super.destroy(self)
end