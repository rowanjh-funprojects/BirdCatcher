function launchMenu()
    buttons = {}
    table.insert(buttons, Button(windowWidth/2, windowHeight/2 - 60, "Start Game", "gotoForest"))
    table.insert(buttons, Button(windowWidth/2, windowHeight/2, "Tutorial", "gotoForest"))
    table.insert(buttons, Button(windowWidth/2, windowHeight/2 + 60, "Credits", "showCredits"))
    table.insert(buttons, Button(windowWidth/2, windowHeight/2 + 120, "Exit", love.event.quit))
    love.graphics.setBackgroundColor(0.05,0.2,0.02)
end