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

    -- -- Show x/y position of entity
    -- if self.x then
    --     love.graphics.circle("fill", self.x, self.y, 5)
    -- end

    -- -- for debugging sprites: pink rectangles
    -- if self.sprite then
    --      love.graphics.setColor(1,0.5,0.5)
    --      love.graphics.rectangle("line", self.x - self.sprite.width/2, self.y - self.sprite.height/2, self.sprite.width, self.sprite.height)
    --      love.graphics.setColor(1,1,1)
    -- end

end

function Entity:destroy()
    self.destroyed = true
    if world:hasItem(self) then
        world:remove(self)
    end
end