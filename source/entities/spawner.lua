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
        self:spawn()
    end
end

function Spawner:spawn()
    self.cd = self.spawntimer
    if self.type == "bird" then
        table.insert(birds, Bird(love.math.random(0, worldWidth), love.math.random(0, worldHeight), bird_speed, 10))
    end
    if self.type == "specialBird" then
        table.insert(birds, specialBird(love.math.random(0, worldWidth), love.math.random(0, worldHeight), bird_speed * 2, 25))
    end
end

function Spawner:destroy()
    Spawner.super.destroy(self)
end