WorldEdge = Entity:extend()

function WorldEdge:new(x,y,width,height)
    WorldEdge.super.new(self, x, y)
    self.width = width
    self.height = height
    world:add(self, self.x, self.y, self.width, self.height)
end

function WorldEdge:destroy()
    WorldEdge.super.destroy(self)
end