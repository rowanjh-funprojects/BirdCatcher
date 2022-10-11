BirdLittleBrown = BirdPerching:extend()

function BirdLittleBrown:new(x, y, speed, value)
    -- Customize sprite

    self.image = love.graphics.newImage("img/little-brown-bird-30px.png")
    local nSpriteCols = 2
    local nSpriteRows = 2
    self.spriteWidth = math.floor(self.image:getWidth() / nSpriteCols)
    self.spriteHeight = math.floor(self.image:getHeight() / nSpriteRows)
    local g = anim8.newGrid(self.spriteWidth, self.spriteHeight, 
                            self.spriteWidth * nSpriteCols, self.spriteHeight * nSpriteRows)
    self.animation = anim8.newAnimation(g(1,1, 2,1, 1,2, 2,2, 1,2, 2,1), 0.1)

    BirdLittleBrown.super.new(self, x, y, speed, value)
    self.value = 5
end

function BirdPerching:update(dt)
    BirdPerching.super.update(self, dt)
end

function BirdPerching:draw()
    BirdPerching.super.draw(self)
end

function BirdPerching:destroy()
    BirdPerching.super.destroy(self)
end
