function loadAudio()
    --BG music
    menuMusic = love.audio.newSource("audio/catch-it.mp3", "stream")
    menuMusic:setLooping(true)
    forestMusic = love.audio.newSource("audio/peaceful-garden.mp3", "stream")
    forestMusic:setLooping(true)
    -- SFX
    squawk1 = love.audio.newSource("audio/bird-chirp1.mp3", "static")
    squawk1:setVolume(0.05)
end