function launchMenu()
    images = {}
    ui.panels = {}
    ui.textblocks = {}
    buttons = {}
    tutorial_elements = {}
    show_tutorial = false

    -- Main menu elements
    table.insert(images, Image(params.winWidth/2, params.winHeight/2, "img/bg-menu-dalle.png"))
    -- table.insert(ui.panels, Panel(params.winWidth/2, 200, 600, 100, {1, 0.9, 0.6, 0.3}))
    table.insert(ui.textblocks, Text(params.winWidth/2, 100, "Bird Catcher", fonts.mainTitle, style.txtCol, style.buttonCol))
    table.insert(buttons, Button(params.winWidth/2, params.winHeight/2 - 75, "Start Game", fonts.regularButton, "gotoForest", style.txtCol, style.buttonCol, "fill"))
    table.insert(buttons, Button(params.winWidth/2, params.winHeight/2, "Tutorial", fonts.regularButton, "showTutorial", style.txtCol, style.buttonCol, "fill"))
    table.insert(buttons, Button(params.winWidth/2, params.winHeight/2 + 75, "Credits", fonts.regularButton, "showCredits", style.txtCol, style.buttonCol, "fill"))
    table.insert(buttons, Button(params.winWidth/2, params.winHeight/2 + 150, "Exit", fonts.regularButton, "quit", style.txtCol, style.buttonCol, "fill"))
    love.graphics.setBackgroundColor(0,0,0)

    -- Tutorial popup elements
    table.insert(tutorial_elements, Panel(params.winWidth/2, 500, 1000, 500, {0.96,0.87,0.70}))
    table.insert(tutorial_elements, Text(params.winWidth/2, 300, "Use arrow keys or WASD to move the character.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 330, "Use spacebar to start laying a net. Spread the net out and press spacebar again to place it, or ESC to cancel.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 360, "When a bird is trapped in the net, walk up to it and HOLD spacebar to attempt to extract it. Don't take too long or it could escape", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 390, "Press ESC to pause.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 420, "Score as many points as you can before the timer runs out!", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 500, "Bird Behaviour Handbook, pp 26: 'Birds typically prefer to perch on certain tree species. Watch carefully how they move.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(params.winWidth/2, 530, "However be cautious, when approached by humans they can become frightened (!)'.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Button(params.winWidth/2, 650, "Close", fonts.regularButton, "closeTutorial", style.txtCol, {1,1,1}, "fill"))
end