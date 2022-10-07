Entity = Object:extend()

function Entity:new(x, y)
    Entity.super.new(self, x, y)
    self.x = x
    self.y = y
end
