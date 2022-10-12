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
