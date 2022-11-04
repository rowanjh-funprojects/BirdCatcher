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
    self.teleporting = false
    self.tpCountdown = 0
    self.flipped = false
    self.canTeleport = true

    -- Setup collision rectangle
    self.boxWidth = math.floor(self.sprite.width / 2)
    self.boxHeight = math.floor(self.sprite.height / 2)
    self.boxOffsetX = self.boxWidth / 2
    self.boxOffsetY = self.boxHeight / 2 - 15
    world:add(self, self.x - self.boxOffsetX, self.y - self.boxOffsetY, self.boxWidth, self.boxHeight)

    -- Add different animations
    self.anim = {}
    self.anim.stand = anim8.newAnimation(self.sprite.g(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,1,2), 0.2)
    self.anim.walk = anim8.newAnimation(self.sprite.g('1-4',3), 0.1)
    -- self.tpAnimation = anim8.newAnimation(self.sprite.g('1-6',5), 0.1)
    -- self.anim.tp = anim8.newAnimation(self.sprite.g('1-3',7,2,7), 0.1)
    -- self.anim.tp = anim8.newAnimation(self.sprite.g('1-8',8, '8-1', 8), 0.1)
    self.anim.tp = anim8.newAnimation(self.sprite.g('1-6',5, '1-6',5, 2,7,2,7,3,7,3,7), 0.13)
    self.sprite.animation = self.anim.stand
end

function Player:update(dt)
    Player.super.update(self, dt)
    self:walk(dt)

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

    if self.teleporting and self.tpCountdown >0 then
        self:tickTpSequence(dt)
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
                                self.sprite.width * 0.667 * ((self.extractingWhichBird.extractResist - self.extractTimer)/self.extractingWhichBird.extractResist),
                                5)
    end
end

function Player:destroy()
    Player.super.destroy(self)
end

function Player:walk(dt)
    -- Manage player walking movemenets: detect when movement arrows are pressed, and
    -- attempt to do that movement with player:move()
    if self.immobilized then
        return
    end
    local goalX = nil
    local goalY = nil
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        if not self.flipped then
            self:toggleAnimFlip()
            self.flipped = true
        end
        goalX = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d")  then
        if self.flipped then
            self:toggleAnimFlip()
            self.flipped = false
        end
        self.flipped = false
        goalX = self.x + self.speed * dt
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        goalY = self.y - self.speed * dt
    elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        goalY = self.y + self.speed * dt
    end
    if goalX or goalY then
        if not goalX then
            goalX = self.x
        elseif not goalY then
            goalY = self.y
        end
        self.sprite.animation = self.anim.walk
        player:move(goalX, goalY)
    else
        -- If no movement, stand animation.
        self.sprite.animation = self.anim.stand
    end
end

function Player:initTpSequence(x,y)
    -- x and y are pixel coordinates of the mouse click. Transform this to world position. 
    self.teleporting = true
    self.tpCountdown = params.tp_countdown
    self.quietCurrentCD = params.player_quiet_cooldown
    self.quiet = false
    local goalX, goalY = cam:toWorld(x,y)
    self.tpDestX = goalX
    self.tpDestY = goalY
    self.immobilized = true
    self.sprite.animation = self.anim.tp
    self.sprite.animation:gotoFrame(1)
end

function Player:tickTpSequence(dt)
    self.tpCountdown = self.tpCountdown - dt
    if self.tpCountdown <=0 then
        self:teleport(self.tpDestX, self.tpDestY)
    end
end

function Player:teleport(x, y)
    -- update position to move without being blocked by trees, then use move to adjust final position with collisions
    world:update(self, x, y)
    self:move(x, y)
    self.teleporting = false
    self.immobilized = false
    self.sprite.animation = self.anim.walk
end

function Player:move(goalX, goalY)
    -- Manage any player movement - walking, teleport.
    self.quiet = false
    self.quietCurrentCD = params.player_quiet_cooldown
    -- Can't move if attempting an extraction
    if self.attemptingExtraction then
        return
    -- Prevent player from going too far away from the temp net's origin point
    elseif self.placing_net then
        -- Get distance between destination and net's origin point
        local goalDistance = math.sqrt((goalY - netTemp.starty)^2 + (goalX - netTemp.startx)^2)
        if goalDistance > netTemp.maxLength then
            -- If the destination would end up too far away, snap to the max range in the same direction.
            local angle = math.atan2(goalY - netTemp.starty, goalX - netTemp.startx)
            local cos = math.cos(angle)
            local sin = math.sin(angle)
            goalX = netTemp.startx + cos * netTemp.maxLength
            goalY = netTemp.starty + sin * netTemp.maxLength
        end
    end
    -- Transform object coordinates to bbox top-left
    goalX = goalX - self.boxOffsetX
    goalY = goalY - self.boxOffsetY
    local resultingX, resultingY
    -- Move the collision rectangle
    resultingX, resultingY, cols, len = world:move(self, goalX, goalY, collision_filter)
    -- Transform bbox coordinates back to original object coordinate
    self.x = resultingX + self.boxOffsetX
    self.y = resultingY + self.boxOffsetY
end

function Player:toggleAnimFlip()
    for k,v in pairs(self.anim) do
        v = v:flipH()
    end
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
    -- self.extractTimer = params.player_extract_duration
    self.extractTimer = thisbird.extractResist
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
            if self.extractingWhichBird.value <= 20 then
                bell:play()
            elseif self.extractingWhichBird.value >20 then
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

