Button = Entity:extend()

function Button:new(x, y, text, action)
    -- X and Y are specified as mid points to the constructor. Then the actual x and y 
    -- of top left corner is recalcualted for printing etc.
    self.scale = 2
    Button.super.new(self)
    self.text = text
    self.action = action
    local font = love.graphics.getFont()
    self.width = font:getWidth(self.text) * self.scale
    self.height = font:getHeight() * self.scale
    -- self.x and self.y will give the top left corner
    self.x = x - self.width / 2
    self.y = y - self.height / 2
    self.highlight = false
end

function Button:update()
    self.highlight = checkMouseHover(self)
end

function Button:draw()
    love.graphics.print(self.text, self.x, self.y, 0, self.scale, self.scale)
    love.graphics.rectangle("line", self.x - 20, self.y - 10, 
                            self.width + 40, self.height + 20)
    if self.highlight then
        love.graphics.rectangle("line", self.x - 30, self.y - 15, 
                                self.width + 60, self.height + 30)

    end
end


