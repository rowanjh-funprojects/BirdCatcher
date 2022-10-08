function launchMenu()
    images = {}
    panels = {}
    textblocks = {}
    buttons = {}

    local txtCol = {0,0,0}
    local buttonCol = {0.96,0.87,0.70, 0.8}

    table.insert(images, Image(windowWidth/2, windowHeight/2, "img/bg-menu-dalle.png"))
    -- table.insert(panels, Panel(windowWidth/2, 200, 600, 100, {1, 0.9, 0.6, 0.3}))
    table.insert(textblocks, Text(windowWidth/2, 100, "Bird Catcher", 10, txtCol, buttonCol))
    table.insert(buttons, Button(windowWidth/2, windowHeight/2 - 75, "Start Game", 3, "gotoForest", txtCol, buttonCol, "fill"))
    table.insert(buttons, Button(windowWidth/2, windowHeight/2, "Tutorial", 3, "showTutorial", txtCol, buttonCol, "fill"))
    table.insert(buttons, Button(windowWidth/2, windowHeight/2 + 75, "Credits", 3, "showCredits", txtCol, buttonCol, "fill"))
    table.insert(buttons, Button(windowWidth/2, windowHeight/2 + 150, "Exit", 3, "quit", txtCol, buttonCol, "fill"))
    love.graphics.setBackgroundColor(buttonCol)
end