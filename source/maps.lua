function launchGamestate(state)
    if state == "menu" then
        destroyAll()
        love.audio.stop()
        -- Create button entities
        launchMenu()
        menuMusic:play()
    elseif state == "forest" then
        destroyAll()
        love.audio.stop()
        createForest()
        forestMusic:play()
        BGbirds:play()
    elseif state == "endround" then
        -- create round end screen 
        roundEnd()
    end
end