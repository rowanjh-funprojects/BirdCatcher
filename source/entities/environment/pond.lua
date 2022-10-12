Pond = EnvElement:extend()

function Pond:new(x, y, sprite)
    Pond.super.new(self, x, y, sprite)
end

function Pond:update(dt)
    Pond.super.update(self, dt)
end

function Pond:draw()
    Pond.super.draw(self)
end

function Pond:destroy()
    Pond.super.destroy(self)
end

function Pond:addToWorld()
    Pond.super.addToWorld(self)
        --setup collision rectangle at base of the tree trunk
        self.boxWidth = self.sprite.width / 1.5
        self.boxHeight = self.sprite.height / 2
        self.boxOffsetX = self.boxWidth / 2
        self.boxOffsetY = self.boxHeight / 2
        world:add(self, self.x - self.boxOffsetX, self.y - self.boxOffsetY, self.boxWidth, self.boxHeight)
    
end
