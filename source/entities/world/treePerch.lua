TreePerch = Tree:extend()

function TreePerch:new(x, y, type)
    TreePerch.super.new(self, x, y, type)
end

function TreePerch:update(dt)
    TreePerch.super.update(self, dt)
end

function TreePerch:draw()
    TreePerch.super.draw(self)
end

function TreePerch:destroy()
    TreePerch.super.destroy(self)
end
