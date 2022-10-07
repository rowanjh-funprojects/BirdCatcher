Panel = Entity:extend()

function Panel:new(x, y, width, height)
    Panel.super.new(self)
    -- X and Y are specified as mid points to the constructor. Then the actual x and y 
    -- of top left corner is recalcualted for printing etc.
    self.width = width
    self.height = height
    self.x = x - self.width / 2
    self.y = y - self.width / 2
end

function Panel:update()
    Panel.super.update(self)
end

function Panel:draw()
    Panel.super.draw(self)
    love.graphics.setColor(1, 0.9, 0.6)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)

end