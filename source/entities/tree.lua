Tree = Sprite:extend()

function Tree:new(x, y, type)
    Tree.super.new(self, x, y)
    self.type = type
    if self.type == "large" then
        self.image = love.graphics.newImage("img/Green-Tree_large_glow.png")
    else
        self.image = love.graphics.newImage("img/Green-Tree_small.png")
    end
    self.spriteWidth = self.image:getWidth()
    self.spriteHeight = self.image:getHeight()
    self.transparent = false
    
    --setup collision rectangle at base of the tree trunk
    self.boxOffsetX = 5
    self.boxOffsetY = self.spriteHeight / 2 - 5
    self.boxWidth = 10
    self.boxHeight = 10
    world:add(self, self.x - self.boxOffsetX, self.y + self.boxOffsetY, self.boxWidth, self.boxHeight)
end

function Tree:update(dt)
    Tree.super.update(self, dt)
    if spriteIntersects(self,player, 1, 0.6) then
        self.transparent = true
    else
        self.transparent = false
    end
end

function Tree:draw()
    Tree.super.draw(self)
    if not self.transparent then
        love.graphics.draw(self.image, self.x - self.spriteWidth / 2, self.y - self.spriteHeight / 2)
    else
        love.graphics.setColor(1,1,1,0.7)
        love.graphics.draw(self.image, self.x - self.spriteWidth / 2, self.y - self.spriteHeight / 2)
        love.graphics.setColor(1,1,1,1)
    end
  end

function Tree:destroy()
    Tree.super.destroy(self)
end
