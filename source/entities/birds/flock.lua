Flock = Object:extend()

function Flock:new(flockLeader)
    Flock.super.new(self)
    self.leader = flockLeader
    self.members = {}
    
    self.destroyed = false
end

function Flock:update(dt)
    Flock.super.update(self)
end

function Flock:destroy()
    self.destroyed = true
end