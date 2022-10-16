Net = Entity:extend()

function Net:new(startx, starty, endx, endy, length)
    Net.super.new(self)
end

function Net:update(dt)
    Net.super.update(self, dt)
end

function Net:draw()
    Net.super.draw(self)
    -- Draw net horizontals
    love.graphics.line(self.startx, self.starty, self.endx, self.endy)
    love.graphics.line(self.startx, self.starty + 16, self.endx, self.endy + 16)
    love.graphics.line(self.startx, self.starty + 8, self.endx, self.endy + 8)
    love.graphics.line(self.startx, self.starty + -8, self.endx, self.endy -8)
    love.graphics.line(self.startx, self.starty + -16, self.endx, self.endy -16)
    -- Draw net verticals
    local incrementdist = 8 -- target mesh size in pixels
    local nincrements = math.abs(math.floor((self.endx - self.startx) / incrementdist))
    if self.startx > self.endx then
        incrementdist = incrementdist * -1
        nincrements = nincrements - 1
    end
    local gradient = (self.endy - self.starty) / (self.endx - self.startx)
    for i=1, nincrements do
        love.graphics.line(self.startx  + incrementdist * i, 
                            self.starty + (incrementdist * i * gradient) + 16, 
                            self.startx  + incrementdist * i, 
                            self.starty + (incrementdist * i * gradient) - 16)
    end

    -- Draw poles at the end of the nest
    love.graphics.setColor(0.2,0.2,0.2)

    love.graphics.rectangle("fill",self.startx - 2, self.starty - 25, 4, 50)
    love.graphics.rectangle("fill",self.endx - 2, self.endy - 25, 4, 50)
    love.graphics.setColor(1,1,1)

end

function Net:destroy()
    Net.super.destroy(self)
end