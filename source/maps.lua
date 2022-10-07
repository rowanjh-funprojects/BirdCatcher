function launchMap(state)
    destroyAll()
    if state == "menu" then
        -- Create button entities
        launchMenu()
    elseif state == "forest" then
        -- destroyMenu()
        createForest()
    end
end

