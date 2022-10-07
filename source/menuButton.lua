MenuButton = Entity:extend()

function MenuButton:new(x, y, text, action)
    -- X and Y are specified as mid points to the constructor. Then the actual x and y 
    -- of top left corner is recalcualted for printing etc.
    MenuButton.super.new(self)
    self.text = text
    self.action = action
    local font = love.graphics.getFont()
    self.width = font:getWidth(self.text)
    self.height = font:getHeight()
    -- self.x and self.y will give the top left corner
    self.x = x - self.width / 2
    self.y = y - self.height / 2
    self.highlight = false
end

function MenuButton:update()
    self.highlight = checkMouseHover(self)
end

function MenuButton:draw()
    love.graphics.print(self.text, self.x, self.y)
    love.graphics.rectangle("line", self.x - 20, self.y - 10, 
                            self.width + 40, self.height + 20)
    if self.highlight then
        love.graphics.rectangle("line", self.x - 30, self.y - 15, 
                                self.width + 60, self.height + 30)

    end
end


