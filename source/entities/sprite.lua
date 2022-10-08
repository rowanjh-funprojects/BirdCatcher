Sprite = Entity:extend()

function Sprite:new(x, y)
    Sprite.super.new(self, x, y)
    self.speaktimer = 0
    self.speakmessage = nil
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
        love.graphics.print(self.speakmessage, self.x, self.y - 15)
    end

    -- for debugging sprites
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Sprite:talk(text, duration)
    self.speakmessage = text
    self.speaktimer = duration
end

function Sprite:destroy()
    Sprite.super.destroy(self)
end

