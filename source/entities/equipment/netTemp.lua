NetTemp = Net:extend()

function NetTemp:new(x, y, maxLength)
    self.startx = x
    self.starty = y
    self.endx = x
    self.endy = y
    self.maxLength = maxLength
    self.destroyed = false
end

function NetTemp:draw()
    love.graphics.setColor(0.6,0.6,0.6)
    NetTemp.super.draw(self)
end

function NetTemp:update(dt, player)
    NetTemp.super.update(self, dt)
    self.endx, self.endy = player.x, player.y
end

function NetTemp:destroy()
    NetTemp.super.destroy(self)
end
