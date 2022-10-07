Sprite = Entity:extend()

function Sprite:new(x, y)
    Sprite.super.new(self, x, y)
end


function Sprite:update()
    Sprite.super.update(self)
end

function Sprite:draw()
    Sprite.super.draw(self)
    -- for debugging sprites
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Sprite:destroy()
    Sprite.super.destroy(self)
end

