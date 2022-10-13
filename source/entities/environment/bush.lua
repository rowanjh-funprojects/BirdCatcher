Bush = EnvElement:extend()

function Bush:new(x, y, sprite)
    Bush.super.new(self, x, y, sprite)
end

function Bush:update(dt)
    Bush.super.update(self, dt)
end

function Bush:draw()
    Bush.super.draw(self)
end

function Bush:destroy()
    Bush.super.destroy(self)
end

function Bush:addToWorld()
    
end