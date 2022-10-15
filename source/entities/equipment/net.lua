-- Net definition
Net = Entity:extend()

function Net:new(startx, starty, endx, endy, length)
    self.startx = startx
    self.starty = starty
    self.endx = endx
    self.endy = endy
    self.length = ((self.startx - self.endx)^2 + (self.starty - self.endy)^2)^0.5
    self.tiles = self:tileize()
    nets_placed = nets_placed + 1
end

function Net:draw(dt)
    Net.super.draw(self, dt)
    love.graphics.setColor(0,0,0)
    -- Draw net horizontals
    love.graphics.line(self.startx, self.starty, self.endx, self.endy)
    love.graphics.line(self.startx, self.starty + 16, self.endx, self.endy + 16)
    love.graphics.line(self.startx, self.starty + 8, self.endx, self.endy + 8)
    love.graphics.line(self.startx, self.starty + -8, self.endx, self.endy -8)
    love.graphics.line(self.startx, self.starty + -16, self.endx, self.endy -16)
    -- Draw net verticals
    local incrementdist = 8 -- target mesh size in pixels
    local nincrements = math.abs(math.floor((self.endx - self.startx) / incrementdist))
    if self.startx > self.endx then
        incrementdist = incrementdist * -1
        nincrements = nincrements - 1
    end
    local gradient = (self.endy - self.starty) / (self.endx - self.startx)
    for i=1, nincrements do
        love.graphics.line(self.startx  + incrementdist * i, 
                            self.starty + (incrementdist * i * gradient) + 16, 
                            self.startx  + incrementdist * i, 
                            self.starty + (incrementdist * i * gradient) - 16)
    end

    -- Draw poles at the end of the nest
    love.graphics.setColor(0.2,0.2,0.2)

    love.graphics.rectangle("fill",self.startx - 2, self.starty - 25, 4, 50)
    love.graphics.rectangle("fill",self.endx - 2, self.endy - 25, 4, 50)
    love.graphics.setColor(1,1,1)
end

function Net:destroy()
    Net.super.destroy(self)
    -- remove tiles
    for i=1, #self.tiles do
        self.tiles[i]:destroy()
    end
end
-- netTiles definition
NetTile = Entity:extend()

function NetTile:new(x, y)
    NetTile.super.new(self, x, y)
    self.boxWidth = 5
    self.boxHeight = 5
    self.boxOffsetX = self.boxWidth / 2
    self.boxOffsetY = self.boxHeight / 2
    self.drawOffsetX = self.boxOffsetX
    self.drawOffsetY = self.boxOffsetY
    world:add(self, self.x - self.boxOffsetX, self.y - self.boxOffsetY, self.boxWidth, self.boxHeight)
end

function NetTile:draw()
    NetTile.super.draw(self)
    love.graphics.rectangle("fill", self.x - self.drawOffsetX, self.y - self.drawOffsetY, 5, 5)
end

function NetTile:destroy()
    NetTile.super.destroy(self)
end

-- Create several tiny collision tiles along the net to get desired behaviour
function Net:tileize()
    local netTiles = {}
    for i=0,50 do
        local x_increment = (self.endx - self.startx) / 50
        local y_increment = (self.endy - self.starty) / 50
        local x = self.startx + x_increment * i
        local y = self.starty + y_increment * i
        table.insert(netTiles, NetTile(x, y))
    end
    return netTiles
end