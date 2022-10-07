Text = Entity:extend()

function Text:new(text, x, y, scale, color)
    Text.super.new(self)
    local font = love.graphics.getFont()

    -- X and Y are specified as mid points to the constructor. Then the actual x and y 
    -- of top left corner is recalcualted for printing etc.
    self.text = text
    self.scale = scale
    if color then
        self.col = color
    end
    self.width = font:getWidth(self.text) * self.scale
    self.height = font:getHeight() * self.scale
    self.x = x - self.width / 2
    self.y = y - self.height / 2
end

function Text:update()
    Text.super.update(self)
end

function Text:draw()
    Text.super.draw(self)
    if self.col then 
        love.graphics.setColor(self.col[1], self.col[2], self.col[3])
        love.graphics.print(self.text, self.x, self.y)
        love.graphics.setColor(1, 1, 1)
    else
        love.graphics.print(self.text, self.x, self.y)
    end
end