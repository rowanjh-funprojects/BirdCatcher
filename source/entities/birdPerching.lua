BirdPerching = Bird:extend()

function BirdPerching:new(x, y, speed, value, perchOn)
    BirdPerching.super.new(self, x, y, speed, value)
    self.perchOn = perchOn
end

function BirdPerching:update(dt)
    BirdPerching.super.update(self, dt)
end

function BirdPerching:draw()
    BirdPerching.super.draw(self)
    love.graphics.rectangle("fill", self.target_x, self.target_y, 10, 10)
end

function BirdPerching:destroy()
    BirdPerching.super.destroy(self)
end

function BirdPerching:selectNewDestination()
    -- Overwrite base Bird behaviour (which is finding a random destination), don't inherit.
    self:findNewPerch()
end

function BirdPerching:findNewPerch()
    local foundDestination = false
    if self.perchOn == "TreePerch" then
        local perchOptions = {}
        for i,v in ipairs(trees) do
            if v:is(TreePerch) then
                table.insert(perchOptions, v)
            end
        end
        if #perchOptions > 0 then
            -- choose from the candidate perches
            local choice = love.math.random(1, #perchOptions)
            self.target_x = perchOptions[choice].x
            self.target_y = perchOptions[choice].y
            foundDestination = true
        end
    end

    if not foundDestination then 
        self:findRandomDestination()
    end
end