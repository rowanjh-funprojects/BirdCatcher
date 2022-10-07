function loadAudio()
    --BG music
    menuMusic = love.audio.newSource("audio/catch-it.mp3", "stream")
    menuMusic:setLooping(true)
    forestMusic = love.audio.newSource("audio/peaceful-garden.mp3", "stream")
    forestMusic:setLooping(true)
    BGbirds = love.audio.newSource("audio/background-birds.wav", "stream")
    BGbirds:setLooping(true)

    -- SFX
    chirp_2 = love.audio.newSource("audio/bird_chirp_generic_2.mp3", "static")
    chirp_3 = love.audio.newSource("audio/bird_chirp_generic_3.mp3", "static")
    chirp_4 = love.audio.newSource("audio/bird_chirp_generic_4.mp3", "static")
    bell = love.audio.newSource("audio/bell.mp3", "static")
    chirp_2:setVolume(0.5)
    chirp_3:setVolume(0.5)
end