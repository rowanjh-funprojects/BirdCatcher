BirdPerching = Bird:extend()

function BirdPerching:new(x, y, speed, value, perchesOn)
    BirdPerching.super.new(self, x, y, speed, value)
    self.perchesOn = perchesOn
end

function BirdPerching:update(dt)
    BirdPerching.super.update(self, dt)

end

function BirdPerching:draw()
    BirdPerching.super.draw(self)
    
    -- draw target for debugging
    love.graphics.setColor(1,0.8,0.3,0.8)
    love.graphics.circle("fill", self.target_x, self.target_y, 3)
    love.graphics.setColor(1,1,1,1)

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
    if self.perchesOn == "TreePerch" then
        local perchOptions = {}
        for i,v in ipairs(trees) do
            if v:is(TreePerch) then
                table.insert(perchOptions, v)
            end
        end
        if #perchOptions > 0 then
            -- choose randomly from the candidate perches (ideally more likely to pick a closer tree)
            local choice = love.math.random(1, #perchOptions)
            local targetTree = perchOptions[choice]
            self.target_x = targetTree.x + love.math.random(targetTree.spriteWidth / 4 * -1, targetTree.spriteWidth / 4)
            self.target_y = targetTree.y + love.math.random(targetTree.spriteHeight / 4 * -1, targetTree.spriteHeight / 4)
            foundDestination = true
        end
    end

    if not foundDestination then 
        self:findRandomDestination()
    end
end