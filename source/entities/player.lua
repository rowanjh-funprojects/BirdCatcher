Player = Sprite:extend()

function Player:new(x, y)
    Player.super.new(self, x, y)

    -- Player parameters
    self.speed = player_speed
    self.skill = player_skill

    -- Player state
    self.placing_net = false
    self.quiet = false
    self.frustration = 0
    self.speaktimer = 0
    self.quiettimer = 5

    -- Sprite, image, animations
    self.image = love.graphics.newImage("img/player_down walk.png")
    local nSpriteCols = 4
    local nSpriteRows = 2
    self.spriteWidth = math.floor(self.image:getWidth() / nSpriteCols)
    self.spriteHeight = math.floor(self.image:getHeight() / nSpriteRows)
    local g = anim8.newGrid(self.spriteWidth, self.spriteHeight, self.spriteWidth * nSpriteCols, self.spriteHeight * nSpriteRows)
    self.animation = anim8.newAnimation(g('1-4', 1), 0.1)

    -- drawing offsets
    self.drawOffsetX = self.spriteWidth / 2
    self.y_drawoffset = self.spriteHeight / 2

    -- Setup collision rectangle
    self.boxWidth = math.floor(self.spriteWidth / 2)
    self.boxHeight = math.floor(self.spriteHeight / 2)
    self.boxOffsetX = self.boxWidth / 2
    self.boxOffsetY = self.boxHeight / 2
    world:add(self, self.x - self.boxOffsetX, self.y - self.boxOffsetY, self.boxWidth, self.boxHeight)
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

    -- Transform coordinates for bounding box offset
    goalX = goalX - self.boxOffsetX
    goalY = goalY - self.boxOffsetY
    local resultingX, resultingY
    resultingX, resultingY, cols, len = world:move(self, goalX, goalY, collision_filter)

    -- Transform coordinates back to original
    self.x = resultingX + self.boxOffsetX
    self.y = resultingY + self.boxOffsetY
    self.animation:update(dt)
end

function Player:draw()
    Player.super.draw(self)
    self.animation:draw(self.image, self.x - self.drawOffsetX, self.y - self.y_drawoffset)
end

function Player:alignNet(maxLength)
    self.placing_net = true
    return TempNet(self.x, self.y, 200, 200, maxLength)
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
    if self:extractSkillCheck() then
        self.frustration = 0
        thisbird:captured()
        if thisbird.value <= 10 then
            bell:play()
        elseif thisbird.value >10 then
            bellMulti:play()
        end
        score = score + thisbird.value
        self:talk("+"..thisbird.value, 1)
        captured_birds = captured_birds + 1
    else
        self.frustration = self.frustration + player_frustration_increment
        thisbird:gotFree()
    end
end

function Player:extractSkillCheck()
    if self.skill + self.frustration >= (love.math.random(0,100)/100) then
        return true
    else 
        self:talk("Bird slipped away!", 2)
        failed_extractions = failed_extractions + 1
    end
end

function Player:destroy()
    Player.super.destroy(self)
end