Rock = EnvElement:extend()

function Rock:new(x, y, sprite)
    Rock.super.new(self, x, y, sprite)
end

function Rock:update(dt)
    Rock.super.update(self, dt)
end

function Rock:draw()
    Rock.super.draw(self)
end

function Rock:destroy()
    Rock.super.destroy(self)
end

function Rock:addToWorld()
    Rock.super.addToWorld(self)
    --setup collision rectangle: bottom half of the self.
    self.boxWidth = self.sprite.width * 0.9
    self.boxHeight = self.sprite.height / 2
    self.boxOffsetX = self.boxWidth / 2
    self.boxOffsetY = -5
world:add(self, self.x - self.boxOffsetX, self.y + self.boxOffsetY, self.boxWidth, self.boxHeight)
end