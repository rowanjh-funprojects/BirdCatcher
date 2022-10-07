function launchGamestate(state)
    destroyAll()
    love.audio.stop()
    if state == "menu" then
        -- Create button entities
        launchMenu()
        menuMusic:play()
    elseif state == "forest" then
        -- destroyMenu()
        createForest()
        forestMusic:play()
    end
end

