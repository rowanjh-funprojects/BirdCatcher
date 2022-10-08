specialBird = Bird:extend()

function specialBird:new(x, y, speed, value)
    specialBird.super.new(self, x, y, speed, value)
end

function specialBird:update(dt)
    specialBird.super.update(self, dt)
end

function specialBird:draw()
    love.graphics.setColor(0.3,0.6,1,0.3)
    love.graphics.circle("fill", self.x + self.width/2, self.y + self.height/2, self.width * 0.8)
    love.graphics.setColor(1,1,1,1)

    specialBird.super.draw(self)
end

function specialBird:destroy()
    specialBird.super.destroy(self)
end

