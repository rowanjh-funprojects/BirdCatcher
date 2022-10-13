function launchMenu()
    images = {}
    ui.panels = {}
    ui.textblocks = {}
    buttons = {}
    tutorial_elements = {}
    show_tutorial = false

    local txtCol = {0,0,0}
    local buttonCol = {0.96,0.87,0.70, 0.8}

    -- Main menu elements
    table.insert(images, Image(params.winWidth/2, params.winHeight/2, "img/bg-menu-dalle.png"))
    -- table.insert(ui.panels, Panel(params.winWidth/2, 200, 600, 100, {1, 0.9, 0.6, 0.3}))
    table.insert(ui.textblocks, Text(params.winWidth/2, 100, "Bird Catcher", 10, txtCol, buttonCol))
    table.insert(buttons, Button(params.winWidth/2, params.winHeight/2 - 75, "Start Game", 3, "gotoForest", txtCol, buttonCol, "fill"))
    table.insert(buttons, Button(params.winWidth/2, params.winHeight/2, "Tutorial", 3, "showTutorial", txtCol, buttonCol, "fill"))
    table.insert(buttons, Button(params.winWidth/2, params.winHeight/2 + 75, "Credits", 3, "showCredits", txtCol, buttonCol, "fill"))
    table.insert(buttons, Button(params.winWidth/2, params.winHeight/2 + 150, "Exit", 3, "quit", txtCol, buttonCol, "fill"))
    love.graphics.setBackgroundColor(0,0,0)

    -- Tutorial popup elements
    table.insert(tutorial_elements, Panel(params.winWidth/2, 500, 1000, 500, {1, 0.9, 0.6,1}))
    table.insert(tutorial_elements, Text(params.winWidth/2, 300, "Use SPACEBAR to start laying a net. Spread the net out and press SPACEBAR again to place it, or ESC to cancel.", 1, txtCol, buttonCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 340, "When a bird is trapped in the net, walk up to it and press spacebar to attempt to extract it. Don't take too long of it could escape", 1, txtCol, buttonCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 380, "Score as many points as you can before the timer runs out.", 1, txtCol, buttonCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 500, "Bird Behaviour Handbook, pp 26: 'Birds typically prefer to perch on certain tree species. Watch carefully how they move. However be cautios, when approached by humans they can become frightened (!)'.", 1, txtCol, buttonCol))
    table.insert(tutorial_elements, Button(params.winWidth/2, 650, "Close", 3, "closeTutorial", txtCol, buttonCol, "fill"))
end