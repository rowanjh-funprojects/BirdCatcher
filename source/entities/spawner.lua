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
    self.cd = self.cd - dt
    if self.cd <= 0 then
        self:spawn()
    end
end

function Spawner:spawn()
    if self.type == "bird" then
        table.insert(birds, Bird(love.math.random(0, worldWidth), love.math.random(0, worldHeight), 10, bird_speed))
        self.cd = self.spawntimer
    end
end