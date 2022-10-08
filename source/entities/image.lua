Image = Entity:extend()
function Image:new(x, y, source)
    -- input x and y gives centrepoint of image, later converted 
    -- to top left corner for collisions (if any) and drawing
    Image.super.new(self, x, y)
    self.image = love.graphics.newImage(source)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Image:update(dt)
    Image.super.update(self, dt)
end

function Image:draw()
    Image.super.draw(self)
    love.graphics.draw(self.image, self.x - self.width/2, self.y - self.height/2)

    -- for debugging sprites
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Image:destroy()
    Image.super.destroy(self)
end
