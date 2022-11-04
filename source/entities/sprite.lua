Sprite = Entity:extend()

function Sprite:new(x, y, sprite)
    Sprite.super.new(self, x, y)
    self.sprite = deepcopy(sprite)
    -- Every sprite can 'talk'
    self.speaktimer = 0
    self.speakmessage = nil
end

function Sprite:update(dt)
    Sprite.super.update(self, dt)
    if self.speaktimer > 0 then
        self.speaktimer = self.speaktimer - dt
    end
    if self.sprite.animated then
        self.sprite.animation:update(dt)
    end
end

function Sprite:draw()
    Sprite.super.draw(self)

    -- Draw animation/image
    if self.sprite.animated then
        self.sprite.animation:draw(self.sprite.image, self.x - self.sprite.drawOffsetX, self.y - self.sprite.drawOffsetY)
    else
        love.graphics.draw(self.sprite.image, self.x - self.sprite.drawOffsetX, self.y - self.sprite.drawOffsetY)
    end

    -- Draw speech
    if self.speaktimer > 0 then
        love.graphics.setFont(fonts.regularText)
        local speechWidth = fonts.regularText:getWidth(self.speakmessage) --gets the width in pixels for this font
        love.graphics.print(self.speakmessage, self.x - speechWidth/2, self.y - self.sprite.height/2 - 5)
    end
end

function Sprite:talk(text, duration)
    self.speakmessage = text
    if duration then
        self.speaktimer = duration
    else
        self.speaktimer = 2
    end
end

function Sprite:destroy()
    Sprite.super.destroy(self)
end

function Sprite:isOffscreen()
    if ((self.x + self.sprite.width / 2) < 0) or (self.x - self.sprite.width / 2) > params.worldWidth then
        if ((self.y  + self.sprite.height / 2) < 0) or (self.y - self.sprite.height / 2) > params.worldHeight then 
            return true
        end
    end
end