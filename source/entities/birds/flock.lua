Flock = Object:extend()

function Flock:new(flockLeader)
    Flock.super.new(self)
    self.leader = flockLeader
    self.followers = {}
    self.destroyed = false
    self.lonelyCurrentCD = 4
    self.flockid = love.math.random(0,100)
end

function Flock:update(dt)
    if self.leader.emigrating or self.leader.trapped then
        self:disband()
    end
    if #self.followers == 0 then
        if self.lonelyCurrentCD <= 0 then 
            self:disband()
        else
            self.lonelyCurrentCD = self.lonelyCurrentCD - dt
        end
    end
end

function Flock:musterTheRohirrem()
    -- synchronize everyone's destination and patience with the leader.
    if #self.followers > 0 then
        for i=1, #self.followers do
            local sign_x = 1
            local sign_y = 1
            if love.math.random(0,1) == 1 then
                -- allow negative or positive offset from flock leader, without including "0" as a possibility
                sign_x = sign_x * -1
            end
            if love.math.random(0,1) == 1 then
                -- allow negative or positive offset from flock leader, without including "0" as a possibility
                sign_y = sign_y * -1
            end

            self.followers[i].target_x = self.leader.target_x + love.math.random(15,35) * sign_x
            self.followers[i].target_y = self.leader.target_y + love.math.random(15,35) * sign_y
            self.followers[i].paused_timer = love.math.random(2,7) / 10
        end
    end
end

function Flock:purgeTheDisbelievers()
    -- Prune some flock members
    if #self.followers > 0 then
        for i=1, #self.followers do
            if params.flock_loyalty <= (love.math.random(0,100)/100) then
                self.followers[i]:leaveFlock()
                self.followers[i]:makeFlock()
            end
        end
    end
end

function Flock:disband()
    self.leader:leaveFlock()
    -- Send followers to other flocks if possible. 
    if #self.followers > 0 then
        for i=1, #self.followers do
            self.followers[i]:leaveFlock()
        end
    end
    self:destroy()
end

function Flock:destroy()
    self.destroyed = true
end