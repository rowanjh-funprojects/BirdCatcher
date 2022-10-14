function launchLevel(gamestate)
    if gamestate == "menu" then
        destroyAll()
        love.audio.stop()
        -- Create button entities
        launchMenu()
        menuMusic:play()
    elseif gamestate == "forest" then
        destroyAll()
        love.audio.stop()
        local spec = require "source/maps/level_forest1"
        generateLevel(spec)
        forestMusic:play()
        BGbirds:play()
    end
end