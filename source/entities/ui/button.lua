Button = Text:extend()

function Button:new(x, y, text, scale, action, txtCol, bCol, fill)
    -- @tCol = text colour
    -- @bCol = button color
    -- @fill = whether button should be "fill"ed or drawn with "line" only
    -- input x and y are treated as mid points, and recalcualted to be 
    -- the top-left corner

    Button.super.new(self, x, y, text, scale, txtCol)
    self.action = action
    if not fill then 
        self.fill = "line" 
    else 
        self.fill = fill 
    end
    self.highlight = false
    if bCol then
        self.bCol = bCol
    else
        self.bCol = {0.92,0.83,0.70}
    end
end

function Button:update()
    Button.super.update(self)
    self.highlight = checkMouseHover(self)
end

function Button:draw()
    love.graphics.setColor(self.bCol)
    love.graphics.rectangle(self.fill, 
                            self.x - self.drawOffsetX - 20, 
                            self.y - self.drawOffsetY - 10, 
                            self.width + 40, self.height + 20)
    if self.highlight then
        love.graphics.rectangle(self.fill, 
                                self.x - self.drawOffsetX - 30, 
                                self.y - self.drawOffsetY - 15, 
                                self.width + 60, self.height + 30)
    end
    love.graphics.setColor(1, 1, 1, 1)

    -- draw text second so that it appears on top if using filled rects
    Button.super.draw(self)
end

function Button:click()
    if self.action == "gotoForest" then
        gamestate = "forest"
        launchGamestate(gamestate)
    elseif self.action == "menu" then
        gamestate = "menu"
        launchGamestate(gamestate)
    elseif self.action == "showTutorial" then
        show_tutorial = true
    elseif self.action == "closeTutorial" then
        show_tutorial = false
    elseif self.action == "quit" then
        love.event.quit()
    elseif self.action == "restart" then
        gamestate = "forest"
        launchGamestate("forest")
    end
end