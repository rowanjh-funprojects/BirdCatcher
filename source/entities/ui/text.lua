Text = Entity:extend()

function Text:new(x, y, text, font, txtCol, wrapWidth, bgpanel)
    -- Text is drawn centered on the x position provided.
    -- A chunk of text with a wrapped textbox can also be supplied. 
    -- In this case, x is the middle, wrapWidth is the width of the chunk, 
    -- y will then give the top of the text chunk.
    --@bgpanel: panel drawn underneath text to make more readble

    Text.super.new(self)
    self.x = x
    self.y = y
    self.font = font
    self.text = text
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
    if wrapWidth then
        self.wrapWidth = wrapWidth
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
    if self.wrapWidth then
        love.graphics.printf(self.text, self.x - self.wrapWidth/2   , self.y, self.wrapWidth, "left")
    else
        love.graphics.print(self.text, self.x - self.drawOffsetX, self.y - self.drawOffsetY)
    end
    love.graphics.setColor(1, 1, 1)
end

function Text:destroy()
    Text.super.destroy(self)
end
