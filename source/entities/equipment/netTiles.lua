-- netTiles definition
NetTile = Entity:extend()

function NetTile:new(x, y)
    NetTile.super.new(self, x, y)
    self.boxWidth = 6
    self.boxHeight = 6
    self.boxOffsetX = self.boxWidth / 2
    self.boxOffsetY = self.boxHeight / 2
    self.drawOffsetX = self.boxOffsetX
    self.drawOffsetY = self.boxOffsetY
    world:add(self, self.x - self.boxOffsetX, self.y - self.boxOffsetY, self.boxWidth, self.boxHeight)
end

function NetTile:draw()
    NetTile.super.draw(self)
end

function NetTile:destroy()
    NetTile.super.destroy(self)
end

