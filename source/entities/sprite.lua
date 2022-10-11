Sprite = Entity:extend()

function Sprite:new(x, y, spriteWidth, spriteWidth)
    Sprite.super.new(self, x, y)
    self.speaktimer = 0
    self.speakmessage = nil
    if spriteWidth then
        self.spriteWidth = spriteWidth
        self.spriteHeight = spriteWidth
    end
end


function Sprite:update(dt)
    Sprite.super.update(self, dt)
    if self.speaktimer > 0 then
        self.speaktimer = self.speaktimer - dt
    end
end

function Sprite:draw()
    Sprite.super.draw(self)
    if self.speaktimer > 0 then
        local font = love.graphics.getFont()
        local speechWidth = font:getWidth(self.speakmessage) --gets the width in pixels for this font
        love.graphics.print(self.speakmessage, self.x - speechWidth/2, self.y - self.spriteHeight/2 - 5)
    end
    -- -- for debugging sprites: pink rectangles
    -- love.graphics.setColor(1,0.5,0.5)
    -- love.graphics.rectangle("line", self.x - self.spriteWidth/2, self.y - self.spriteHeight/2, self.spriteWidth, self.spriteHeight)
    -- love.graphics.setColor(1,1,1)
end

function Sprite:talk(text, duration)
    self.speakmessage = text
    self.speaktimer = duration
end

function Sprite:destroy()
    Sprite.super.destroy(self)
end

function Sprite:isOffscreen()
    if ((self.x + self.spriteWidth / 2) < 0) or (self.x - self.spriteWidth / 2) > worldWidth then
        if ((self.y  + self.spriteHeight / 2) < 0) or (self.y - self.spriteHeight / 2) > worldHeight then 
            return true
        end
    end
end