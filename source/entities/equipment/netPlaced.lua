-- Net definition
NetPlaced = Net:extend()

function NetPlaced:new(startx, starty, endx, endy, length)
    self.startx = startx
    self.starty = starty
    self.endx = endx
    self.endy = endy
    self.length = ((self.startx - self.endx)^2 + (self.starty - self.endy)^2)^0.5
    self.tiles = self:tileize()
    nets_placed = nets_placed + 1
end

function NetPlaced:draw(dt)
    love.graphics.setColor(0,0,0)
    NetPlaced.super.draw(self, dt)
    for i=1, #self.tiles do
        self.tiles[i]:draw() -- in case tiles need to be drawn for debugging
    end
end

function NetPlaced:destroy()
    NetPlaced.super.destroy(self)
    -- remove tiles
    for i=1, #self.tiles do
        self.tiles[i]:destroy()
    end
end

-- Create several tiny collision tiles along the net to get desired behaviour
function NetPlaced:tileize()
    local netTiles = {}
    local spacing = 8
    local netlength = get_dist_points(self.startx, self.starty, self.endx, self.endy) 
    local increments = netlength / spacing

    for i=0,increments do
        local x_increment = (self.endx - self.startx) / increments
        local y_increment = (self.endy - self.starty) / increments
        local x = self.startx + x_increment * i
        local y = self.starty + y_increment * i
        table.insert(netTiles, NetTile(x, y))
    end
    return netTiles
end