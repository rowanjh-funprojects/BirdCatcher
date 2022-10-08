Sound = Object:extend()
-- This object overwrites sound behaviour, so that multiple triggers of a sound
-- in a short amount of time re-launch the sound clip. Access base love.audio
-- functions with Sound.sound e.g. Sound.sound:play() Sound.sound.setLooping()
function Sound:new(source, type)
    Sound.super.new(self)
    self.sound = love.audio.newSource(source, type)
end

function Sound:play()
    if self.sound:isPlaying() then
        self.sound:stop()
    end
    self.sound:play()
end