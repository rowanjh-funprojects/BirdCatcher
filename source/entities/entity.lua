Entity = Object:extend()

function Entity:new(x, y)
    Entity.super.new(self)
    self.x = x
    self.y = y
    self.destroyed = false
end

function Entity:update(dt)
end

function Entity:draw()
    -- -- For debugging collision rectangles (blue rectangles)
    -- if world:hasItem(self) then
    --     love.graphics.setColor(0.5,1,1)
    --     local x, y, w, h = world:getRect(self)
    --     love.graphics.rectangle("line", x, y, w, h)
    --     love.graphics.setColor(1,1,1)
    -- end
    -- if self.x then
    --     -- Show x/y position of entity
    --     love.graphics.circle("fill", self.x, self.y, 5)
    -- end
end

function Entity:destroy()
    self.destroyed = true
    if world:hasItem(self) then
        world:remove(self)
    end
end