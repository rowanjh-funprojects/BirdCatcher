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
    love.graphics.line(self.startx, self.starty, self.endx, self.endy)
end

function TempNet:update()
    self.endx, self.endy = player.x + player.width/2 - player.bbox_x_offset, player.y + player.height/2 - player.bbox_x_offset
end

function TempNet:destroy()
    TempNet.super.destroy(self)
end
