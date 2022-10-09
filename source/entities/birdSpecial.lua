BirdSpecial = Bird:extend()

function BirdSpecial:new(x, y, speed, value)
    BirdSpecial.super.new(self, x, y, speed, value)
end

function BirdSpecial:update(dt)
    BirdSpecial.super.update(self, dt)
end

function BirdSpecial:draw()
    love.graphics.setColor(0.3,0.6,1,0.3)
    love.graphics.circle("fill", self.x + self.width/2, self.y + self.height/2, self.width * 0.8)
    love.graphics.setColor(1,1,1,1)

    BirdSpecial.super.draw(self)
end

function BirdSpecial:destroy()
    BirdSpecial.super.destroy(self)
end

