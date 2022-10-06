Sprite = Object:extend()

function Sprite:new(x, y)
    self.x = x
    self.y = y
end

function Sprite:draw()
    -- love.graphics.rectangle("fill", self.x + self.width/4, self.y + self.height/4, self.width/2, self.height/2)
end
