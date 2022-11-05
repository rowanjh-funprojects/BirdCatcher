function loadAudio()
    --BG music
    menuMusic = Sound("audio/catch-it.mp3", "stream")
    forestMusic = Sound("audio/peaceful-garden.mp3", "stream")
    BGbirds = Sound("audio/background-birds.mp3", "stream")
    menuMusic.sound:setLooping(true)
    forestMusic.sound:setLooping(true)
    BGbirds.sound:setLooping(true)

    -- SFX
    chirp_2 = Sound("audio/bird_chirp_generic_2.mp3", "static")
    chirp_3 = Sound("audio/bird_chirp_generic_3.mp3", "static")
    bell = Sound("audio/bell.mp3", "static")
    bellMulti = Sound("audio/bell-multiple-short.mp3", "static")
    catPurr = Sound("audio/cat-purr-short.mp3", "static")
    teleport = Sound("audio/teleport.mp3", "static")
    chirp_2.sound:setVolume(0.5)
    chirp_3.sound:setVolume(0.5)
    catPurr.sound:setVolume(0.5)
end