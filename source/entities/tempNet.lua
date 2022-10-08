TempNet = Entity:extend()

function TempNet:new(x, y, maxLength)
    self.startx = x
    self.starty = y
    self.endx = x
    self.endy = y
    self.maxLength = maxLength
    self.destroyed = false
end

function TempNet:draw()
    TempNet.super.draw(self)
    love.graphics.setColor(0.6,0.6,0.6)
    love.graphics.line(self.startx, self.starty, self.endx, self.endy)
    love.graphics.setColor(1,1,1)

end

function TempNet:update()
    TempNet.super.update(self)
    self.endx, self.endy = player.x + player.width/2 - player.bbox_x_offset, player.y + player.height/2 - player.bbox_x_offset
end

function TempNet:destroy()
    TempNet.super.destroy(self)
end
