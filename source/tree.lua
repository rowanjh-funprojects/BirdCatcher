Tree = Sprite:extend()

function Tree:new(x, y, size)
    Tree.super.new(self, x, y)
    self.size = size

    -- Animations
    if self.size == "large" then
        self.image = love.graphics.newImage("img/Green-Tree_large.png")
    else
        self.image = love.graphics.newImage("img/Green-Tree_small.png")
    end
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    world:add(self, self.x, self.y, self.width, self.height)
    -- self.scare_timer = 2
end

function Tree:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
