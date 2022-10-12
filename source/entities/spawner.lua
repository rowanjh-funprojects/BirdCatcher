Spawner = Entity:extend()

function Spawner:new(birdType, birdX, birdY, birdSprite, birdSpeed, birdValue, spawncd, initialcd)
    ---@birdX location to spawn bird. Can be "random" and a random spot around edge of map will be selected
    ---@birdY location to spawn bird. Can be "random" and a random spot around edge of map will be selected
    ---@birdSprite sprite of the bird to spawn
    ---@birdSpeed speed of spawned birds
    ---@birdValue score value of spawned birds
    ---@spawncd cooldown of spawner 
    ---@initialcd time until the first spawn instance, after which subsequent spawns will occur every <spawncd> seconds.
    ---           initialcd is overwritten if spawnNow() is manually called at map generation
    Spawner.super.new(self)
    self.birdType = birdType
    self.birdX = birdX
    self.birdY = birdY
    self.birdSprite = birdSprite
    self.birdSpeed = birdSpeed
    self.birdValue = birdValue
    self.spawncd = spawncd
    if initialcd then
        self.timeTillNextSpawn = initialcd
    else
        self.timeTillNextSpawn = self.spawncd
    end
end

function Spawner:update(dt)
    Spawner.super.update(self,dt)
    self.timeTillNextSpawn = self.timeTillNextSpawn - dt
    if self.timeTillNextSpawn <= 0 then
        self:spawnNow()
    end
end

function Spawner:spawnNow()
    local x, y
    if self.birdX == "random" or self.birdY == "random" then
        x, y = getOffscreenPoint()
    else
        x = self.birdX
        y = self.birdY
    end

    self.timeTillNextSpawn = self.spawncd
    if self.birdType == "Bird" then
        table.insert(birds, Bird(x, y, self.birdSprite, self.birdSpeed, self.birdValue))
    end
    if self.birdType == "BirdPerching" then
        table.insert(birds, BirdPerching(x, y, self.birdSprite, self.birdSpeed, self.birdValue, "TreePerch"))
    end
end

function Spawner:destroy()
    Spawner.super.destroy(self)
end