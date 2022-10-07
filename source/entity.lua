Entity = Object:extend()

function Entity:new(x, y)
    Entity.super.new(self)
    self.x = x
    self.y = y
    self.destroyed = false
end

function Entity:destroy()
    self.destroyed = true
end