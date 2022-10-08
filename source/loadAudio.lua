function loadAudio()
    --BG music
    menuMusic = Sound("audio/catch-it.mp3", "stream")
    menuMusic.sound:setLooping(true)
    forestMusic = Sound("audio/peaceful-garden.mp3", "stream")
    forestMusic.sound:setLooping(true)
    BGbirds = Sound("audio/background-birds.wav", "stream")
    BGbirds.sound:setLooping(true)

    -- SFX
    chirp_2 = Sound("audio/bird_chirp_generic_2.mp3", "static")
    chirp_3 = Sound("audio/bird_chirp_generic_3.mp3", "static")
    chirp_4 = Sound("audio/bird_chirp_generic_4.mp3", "static")
    bell = Sound("audio/bell.mp3", "static")
    bellMulti = Sound("audio/bell-multiple-short.mp3", "static")
    chirp_2.sound:setVolume(0.5)
    chirp_3.sound:setVolume(0.5)
end