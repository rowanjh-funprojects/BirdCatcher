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

function TempNet:confirmNet()
    local length = ((self.startx - self.endx)^2 + (self.starty - self.endy)^2)^0.5
    local net = Net(self.startx, self.starty, self.endx, self.endy, length)
    local netTiles = net:tileize()
    self.startx, self.starty, self.endx, self.endy = 0, 0, 0, 0
    return net, netTiles
end

function TempNet:destroy()
    self.destroyed = true
end
