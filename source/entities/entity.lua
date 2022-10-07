Entity = Object:extend()

function Entity:new(x, y)
    Entity.super.new(self)
    self.x = x
    self.y = y
    self.destroyed = false
end

function Entity:update()
    
end

function Entity:draw()
    -- For collision debugging
    -- if world:hasItem(self) then
    --     local x, y, w, h = world:getRect(self)
    --     love.graphics.rectangle("line", x, y, w, h)
    -- end
end

function Entity:destroy()
    self.destroyed = true
end