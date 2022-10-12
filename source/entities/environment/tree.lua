Tree = EnvElement:extend()

function Tree:new(x, y, img)
    Tree.super.new(self, x, y, img)
    self.transparent = false
    
    --setup collision rectangle at base of the tree trunk
    self.boxOffsetX = 5
    self.boxOffsetY = self.sprite.height / 2 - 5
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
    if not self.transparent then
        Tree.super.draw(self)
    else
        love.graphics.setColor(1,1,1,0.7)
        love.graphics.draw(self.sprite.image, self.x - self.sprite.width / 2, self.y - self.sprite.height / 2)
        love.graphics.setColor(1,1,1,1)
    end
  end

function Tree:destroy()
    Tree.super.destroy(self)
end
