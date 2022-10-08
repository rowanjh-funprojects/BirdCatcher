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
    love.graphics.setColor(0.6,0.6,0.6)
    love.graphics.line(self.startx, self.starty, self.endx, self.endy)
    for i=1, #self.tiles do
        self.tiles[i]:draw()
    end
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
    world:add(self, self.x, self.y, 5, 5)
end

function NetTile:draw()
    NetTile.super.draw(self)
    love.graphics.rectangle("fill", self.x, self.y, 5, 5)
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

function killOldNet()
    if #netTiles > 0 then
        for i = #netTiles, 1, -1 do
            world:remove(netTiles[i])
            table.remove(netTiles, i)
        end
    end
end