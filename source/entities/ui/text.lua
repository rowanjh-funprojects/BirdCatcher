Text = Entity:extend()

function Text:new(x, y, text, font, txtCol, bgpanel)
    --@bgpanel: panel drawn underneath text to make more readble
    Text.super.new(self)
    self.x = x
    self.y = y
    self.font = font
    self.text = text
    self.scale = scale
    self.width = self.font:getWidth(self.text)
    self.height = self.font:getHeight()
    
    if txtCol then
        self.txtCol = txtCol
    else
        self.txtCol = {1,1,1}
    end
    if bgpanel then
        self.bgpanel = bgpanel
    end 
    -- arguments X and Y specify mid pointsof the text. Calculate the
    -- draw offset for top left corner's position.
    self.drawOffsetX = self.width / 2
    self.drawOffsetY = self.height / 2
end

function Text:update()
    Text.super.update(self)
end

function Text:draw()
    Text.super.draw(self)
    love.graphics.setFont(self.font)
    if self.bgpanel then
        love.graphics.setColor(self.bgpanel)
        local buffer = 10
        love.graphics.rectangle("fill", self.x - self.drawOffsetX - buffer, 
                                self.y - self.drawOffsetY - buffer, 
                                self.width + buffer * 2, self.height + buffer * 2,
                                30,30)
    end
    love.graphics.setColor(self.txtCol)
    love.graphics.print(self.text, self.x - self.drawOffsetX, self.y  - self.drawOffsetY, 0, self.scale, self.scale)
    love.graphics.setColor(1, 1, 1)
end

function Text:destroy()
    Text.super.destroy(self)
end
