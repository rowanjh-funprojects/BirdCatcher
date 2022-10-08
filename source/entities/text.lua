Text = Entity:extend()

function Text:new(x, y, text, scale, txtCol, bgpanel)
    --@bgpanel: panel drawn underneath text to make more readble
    Text.super.new(self)
    local font = love.graphics.getFont()
    self.text = text
    self.scale = scale
    self.width = font:getWidth(self.text) * self.scale
    self.height = font:getHeight() * self.scale
    self.x = x - self.width / 2
    self.y = y - self.height / 2
    
    if txtCol then
        self.txtCol = txtCol
    else
        self.txtCol = {1,1,1}
    end
    if bgpanel then
        self.bgpanel = bgpanel
    end 
    -- arguments X and Y specify mid pointsof the text. Calculate the top
    -- left corner's position.
    self.x = x - self.width / 2
    self.y = y - self.height / 2
end

function Text:update()
    Text.super.update(self)
end

function Text:draw()
    Text.super.draw(self)
    if self.bgpanel then
        love.graphics.setColor(self.bgpanel)
        local buffer = 10
        love.graphics.rectangle("fill", self.x - buffer, self.y - buffer, 
                                self.width + buffer * 2, self.height + buffer * 2)
    end
    love.graphics.setColor(self.txtCol)
    love.graphics.print(self.text, self.x, self.y, 0, self.scale, self.scale)
    love.graphics.setColor(1, 1, 1)
end

function Text:destroy()
    Text.super.destroy(self)
end
