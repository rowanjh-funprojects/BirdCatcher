Spawner = Entity:extend()

function Spawner:new(type, spawntimer, initialcd)
    Spawner.super.new(self)
    self.type = type
    self.spawntimer = spawntimer
    if initialcd then
        self.cd = initialcd
    else
        self.cd = spawntimer
    end
end

function Spawner:update(dt)
    Spawner.super.update(self,dt)
    self.cd = self.cd - dt
    if self.cd <= 0 then
        self:spawnNow()
    end
end

function Spawner:spawnNow()
    self.cd = self.spawntimer
    if self.type == "Bird" then
        table.insert(birds, Bird(love.math.random(0, worldWidth), love.math.random(0, worldHeight), bird_speed, 10))
    end
    if self.type == "BirdSpecial" then
        table.insert(birds, BirdSpecial(love.math.random(0, worldWidth), love.math.random(0, worldHeight), bird_speed * 2, 25))
    end
    if self.type == "BirdPerching" then
        table.insert(birds, BirdPerching(love.math.random(0, worldWidth), love.math.random(0, worldHeight), bird_speed, 10, "TreePerch"))
    end
end

function Spawner:destroy()
    Spawner.super.destroy(self)
end