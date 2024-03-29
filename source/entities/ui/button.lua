Button = Text:extend()

function Button:new(x, y, text, font, action, txtCol, bCol, fill)
    -- @tCol = text colour
    -- @bCol = button color
    -- @fill = whether button should be "fill"ed or drawn with "line" only
    -- input x and y are treated as mid points, and recalcualted to be 
    -- the top-left corner

    Button.super.new(self, x, y, text, font, txtCol)
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
                            self.x - self.drawOffsetX - self.height * 0.3, -- use height as the main buffer, consistent regardless of nchar 
                            self.y - self.drawOffsetY - self.height * 0.3, 
                            self.width + self.height * 0.6, self.height + self.height * 0.6, -- width/height
                            self.height * 0.4, self.height * 0.4)--rounding
    if self.highlight then
        love.graphics.rectangle(self.fill, 
                                self.x - self.drawOffsetX - self.height * 0.35, -- use height as the main buffer, consistent regardless of nchar 
                                self.y - self.drawOffsetY - self.height * 0.35, 
                                self.width + self.height * 0.7, self.height + self.height * 0.7, -- width/height
                                self.height * 0.4, self.height * 0.4)--rounding
    end
    love.graphics.setColor(1, 1, 1, 1)

    -- draw text second so that it appears on top if using filled rects
    Button.super.draw(self)
end

function Button:click()
    if self.action == "gotoForest" then
        globals.gamestate = "forest"
        launchLevel(globals.gamestate)
    elseif self.action == "menu" then
        globals.gamestate = "menu"
        launchLevel(globals.gamestate)
    elseif self.action == "showTutorial" then
        show_tutorial = true
    elseif self.action == "closeTutorial" then
        show_tutorial = false
    elseif self.action == "quit" then
        love.event.quit()
    elseif self.action == "restart" then
        globals.gamestate = "forest"
        launchLevel(globals.gamestate)
    elseif self.action == "resume" then
        globals.paused = false
        tag_as_destoyed(buttons)
        remove_if_destroyed(buttons)    
        tag_as_destoyed(ui.panels)
        remove_if_destroyed(ui.panels)    
        tag_as_destoyed(ui.textblocks)
        remove_if_destroyed(ui.textblocks)    
    end
end