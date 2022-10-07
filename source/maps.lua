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
        table.insert(panels, Panel(windowWidth/2, windowHeight/2, windowWidth/2, windowHeight/2))
        table.insert(textblocks, Text("Round Over", windowWidth/2, windowHeight/4, 3, {0,0,0}))
        table.insert(textblocks, Text("Score: " .. score, windowWidth/2, windowHeight/4 + 30, 3, {0,0,0}))
        table.insert(textblocks, Text("Press R to try again" , windowWidth/2, windowHeight/4 + 60, 3, {0,0,0}))
    end
end