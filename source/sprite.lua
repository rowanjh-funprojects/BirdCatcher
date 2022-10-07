Sprite = Entity:extend()

function Sprite:new(x, y)
end

function Sprite:draw()
    -- for debugging sprites
    -- love.graphics.rectangle("fill", self.x + self.width/4, self.y + self.height/4, self.width/2, self.height/2)
end
