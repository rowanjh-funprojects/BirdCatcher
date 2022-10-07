function launchMenu()
    menu1 = MenuButton(windowWidth/2, windowHeight/2 - 50, "Start Game", "gotoForest")
    menu2 = MenuButton(windowWidth/2, windowHeight/2, "Tutorial", "gotoForest")
    menu3 = MenuButton(windowWidth/2, windowHeight/2 + 50, "Exit", love.event.quit)
    love.graphics.setBackgroundColor(0.05,0.2,0.02)
end