Sprite = Object:extend()

function Sprite:new(x, y, image_path)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(image_path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    world:add(self, self.x, self.y, self.width/2+self.width/4, self.height/2 + self.height/4)
end

function Sprite:draw()
    love.graphics.rectangle("fill", self.x + self.width/4, self.y + self.height/4, self.width/2, self.height/2)
    love.graphics.draw(self.image, self.x, self.y)
end
