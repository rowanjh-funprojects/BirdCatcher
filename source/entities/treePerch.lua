TreePerch = Tree:extend()

function TreePerch:new(x, y, type)
    TreePerch.super.new(self, x, y, type)
end

function TreePerch:update(dt)
    TreePerch.super.update(self, dt)
end

function TreePerch:draw()
    love.graphics.setColor(0.25,1,0.72,1)
    TreePerch.super.draw(self)
    love.graphics.setColor(1,1,1,1)

end

function TreePerch:destroy()
    TreePerch.super.destroy(self)
end
