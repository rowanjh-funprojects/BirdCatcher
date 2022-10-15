Panel = Entity:extend()

function Panel:new(x, y, width, height, col)
    Panel.super.new(self, x, y)
    -- X and Y are specified as mid points for the panel.
    -- The x and y of top left corner is calculated for drawing later
    self.width = width
    self.height = height
    if col then
        self.col = col
    else
        self.col = {1, 0.9, 0.6}
    end
end

function Panel:update(dt)
    Panel.super.update(self, dt)
end

function Panel:draw()
    Panel.super.draw(self)
    love.graphics.setColor(self.col[1], self.col[2], self.col[3], self.col[4])
    love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height, self.width/8, self.height/8)
    love.graphics.setColor(1, 1, 1)
end

function Panel:destroy()
    Panel.super.destroy(self)
end