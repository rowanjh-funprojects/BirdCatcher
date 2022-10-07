Tree = Sprite:extend()

function Tree:new(x, y, type)
    Tree.super.new(self, x, y)
    self.type = type
    -- Animations
    if self.type == "large" then
        self.image = love.graphics.newImage("img/Green-Tree_large.png")
    else
        self.image = love.graphics.newImage("img/Green-Tree_small.png")
    end
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.transparent = false
    
    --setup collision rectangle
    self.bbox_x_offset = self.width / 2.2
    self.bbox_y_offset = self.height-10
    self.bbox_width = 10
    self.bbox_height = 10
    world:add(self, self.x + self.bbox_x_offset, self.y + self.bbox_y_offset, 
              self.bbox_width, self.bbox_height)
end

function Tree:update()
    Tree.super.update(self)
    if intersects(self,player, 1, 0.6) then
        self.transparent = true
    else
        self.transparent = false
    end
end

function Tree:draw()
    Tree.super.draw(self)
    if not self.transparent then
        love.graphics.draw(self.image, self.x, self.y)
    else
        love.graphics.setColor(1,1,1,0.7)
        love.graphics.draw(self.image, self.x, self.y)
        love.graphics.setColor(1,1,1,1)
    end
    -- -- draw bbox (debugging)
    -- local x, y, w, h = world:getRect(self)
    -- love.graphics.rectangle("line", x, y, w, h)
  end
