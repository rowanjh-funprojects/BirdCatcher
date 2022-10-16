Player = Sprite:extend()

function Player:new(x, y, sprite)
    Player.super.new(self, x, y, sprite)

    -- Player parameters
    self.speed = params.player_speed
    self.skill = params.player_skill

    -- Player state
    self.placing_net = false
    self.quiet = false
    self.frustration = 0
    self.quietCurrentCD = params.player_quiet_cooldown
    self.extractTimer = params.player_extract_duration
    self.attemptingExtraction = false
    self.extractingWhichBird = nil

    -- Setup collision rectangle
    self.boxWidth = math.floor(self.sprite.width / 2)
    self.boxHeight = math.floor(self.sprite.height / 2)
    self.boxOffsetX = self.boxWidth / 2
    self.boxOffsetY = self.boxHeight / 2 - 15
    world:add(self, self.x - self.boxOffsetX, self.y - self.boxOffsetY, self.boxWidth, self.boxHeight)
end

function Player:update(dt)
    Player.super.update(self, dt)
    self:move(dt)

    -- Increment timers
    if self.quietCurrentCD >= 0 then
        self.quietCurrentCD = self.quietCurrentCD - dt
    else
        self.quiet = true
    end

    if self.attemptingExtraction and love.keyboard.isDown("space") then
        self.extractTimer = self.extractTimer - dt
        self:tryToExtractBird()
    elseif self.attemptingExtraction and not love.keyboard.isDown("space") then
        self.attemptingExtraction = false -- kill extraction attempt
    end

    if self.quiet then
        self:talk("shhh",0.01)
    end
end

function Player:draw()
    if player.quiet then
        love.graphics.setColor(1,1,1,0.5)
        Player.super.draw(self)
        love.graphics.setColor(1,1,1,1)
    else
        Player.super.draw(self)
    end
    if self.attemptingExtraction then
        love.graphics.rectangle("line", self.x - self.sprite.width/3, self.y - self.sprite.height / 2 - 10, self.sprite.width * 0.667, 5)
        love.graphics.rectangle("fill", self.x - self.sprite.width/3, self.y - self.sprite.height / 2 - 10, 
                                self.sprite.width * 0.667 * ((params.player_extract_duration - self.extractTimer)/params.player_extract_duration),
                                5)
    end
end

function Player:destroy()
    Player.super.destroy(self)
end

function Player:move(dt)
    -- Manage player movements
    if self.attemptingExtraction then
        -- Can't move if attempting an extraction
        return
    end

    local goalX = self.x
    local goalY = self.y
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        goalX = self.x - self.speed * dt
        self.quiet = false
        self.quietCurrentCD = params.player_quiet_cooldown
    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d")  then
        goalX = self.x + self.speed * dt
        self.quiet = false
        self.quietCurrentCD = params.player_quiet_cooldown
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        goalY = self.y - self.speed * dt
        self.quiet = false
        self.quietCurrentCD = params.player_quiet_cooldown
    elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        goalY = self.y + self.speed * dt
        self.quiet = false
        self.quietCurrentCD = params.player_quiet_cooldown
    end

    -- Prevent player from going too far away from the temp net's origin point
    if self.placing_net then
        local new_dist = math.sqrt((goalY - netTemp.starty)^2 + (goalX - netTemp.startx)^2)
        if new_dist > netTemp.maxLength then
            local angle = math.atan2(goalY - netTemp.starty, goalX - netTemp.startx)
            local cos = math.cos(angle)
            local sin = math.sin(angle)
            goalX = netTemp.startx + cos * netTemp.maxLength
            goalY = netTemp.starty + sin * netTemp.maxLength
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
end

function Player:alignNet(maxLength)
    self.placing_net = true
    return NetTemp(self.x, self.y, 200, 200, maxLength)
end

function Player:check_bird_captures()
    local any_birds_capturable = false
    local closest_dist = -1
    local nearest_bird = nil
    for i,v in ipairs(birds) do
        if v.trapped == true then
            local distance = get_dist_objs(self, v)
            if distance <= params.capture_range then
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

function Player:startExtractionAttempt(thisbird)
    self.attemptingExtraction = true
    self.extractingWhichBird = thisbird
    thisbird:beingExtracted()
    self.extractTimer = params.player_extract_duration
end

function Player:tryToExtractBird()
    self.quiet = false
    self.quietCurrentCD = params.player_quiet_cooldown
    if not self.extractingWhichBird.underExtraction then
        -- If the bird got free while trying to extract it
        self.attemptingExtraction = false
        self.extractingWhichBird = nil
    end
    if self.extractTimer <=0 then
        if self:extractSkillCheck() then
            self.frustration = 0
            self.extractingWhichBird:gotCaptured()
            if self.extractingWhichBird.value <= 10 then
                bell:play()
            elseif self.extractingWhichBird.value >10 then
                bellMulti:play()
            end
            score = score + self.extractingWhichBird.value
            self:talk("+"..self.extractingWhichBird.value, 1)
            captured_birds = captured_birds + 1
        else
            self.frustration = self.frustration + params.player_frustration_increment
            self.extractingWhichBird:gotFree()
        end
        self.attemptingExtraction = false
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

