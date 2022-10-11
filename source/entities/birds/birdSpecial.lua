BirdSpecial = Bird:extend()

function BirdSpecial:new(x, y, speed, value)
    self.image = love.graphics.newImage("img/parrot-60px.png")
    local nSpriteCols = 4
    local nSpriteRows = 4
    self.spriteWidth = math.floor(self.image:getWidth() / nSpriteCols)
    self.spriteHeight = math.floor(self.image:getHeight() / nSpriteRows)
    local g = anim8.newGrid(self.spriteWidth, self.spriteHeight, 
                            self.spriteWidth * nSpriteCols, self.spriteHeight * nSpriteRows)
    self.animation = anim8.newAnimation(g('1-4', '1-2'), 0.1)
    BirdSpecial.super.new(self, x, y, speed, value)
end

function BirdSpecial:update(dt)
    BirdSpecial.super.update(self, dt)
end

function BirdSpecial:draw()
    -- love.graphics.setColor(0.3,0.6,1,0.3)
    -- love.graphics.circle("fill", self.x, self.y, self.spriteWidth * 0.5)
    -- love.graphics.setColor(1,1,1,1)

    BirdSpecial.super.draw(self)
end

function BirdSpecial:destroy()
    BirdSpecial.super.destroy(self)
end

