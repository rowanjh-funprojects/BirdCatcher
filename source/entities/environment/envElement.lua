EnvElement = Sprite:extend()

function EnvElement:new(x, y, sprite)
    EnvElement.super.new(self, x, y, sprite)
end

function EnvElement:update(dt)
    EnvElement.super.update(self, dt)
end

function EnvElement:draw()
    EnvElement.super.draw(self)
end

function EnvElement:destroy()
    EnvElement.super.destroy(self)
end

function EnvElement:addToWorld()
    
end