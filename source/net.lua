Net = Entity:extend()

function Net:new(startx, starty, endx, endy, length)
    self.startx = startx
    self.starty = starty
    self.endx = endx
    self.endy = endy
    self.length = length
end

function Net:draw()
    love.graphics.line(self.startx, self.starty, self.endx, self.endy)
end

NetTile = Entity:extend()

function NetTile:new(x, y)
    Entity.super.new(self, x, y)
    world:add(self, self.x, self.y, 5, 5)
end

function NetTile:draw()
    love.graphics.rectangle("fill", self.x, self.y, 5, 5)
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