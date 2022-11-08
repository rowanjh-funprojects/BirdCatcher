function launchMenu()
    images = {}
    ui.panels = {}
    ui.textblocks = {}
    buttons = {}
    tutorial_elements = {}
    show_tutorial = false

    -- use game units instead preferably..
    local xmid = params.gameWidth / 2
    local ymid = params.gameHeight / 2
    local yquart = params.gameHeight * 0.25

    -- Main menu elements
    table.insert(images, Image(xmid, ymid, "img/bg-menu-dalle.png"))
    table.insert(ui.textblocks, Text(xmid, 100, "Bird Catcher", fonts.mainTitle, style.txtCol, style.buttonCol))
    table.insert(buttons, Button(xmid, ymid, "Start Game", fonts.regularButton, "gotoForest", style.txtCol, style.buttonCol, "fill"))
    table.insert(buttons, Button(xmid, ymid + 75, "Tutorial", fonts.regularButton, "showTutorial", style.txtCol, style.buttonCol, "fill"))
    -- table.insert(buttons, Button(xmid, ymid + 75, "Credits", fonts.regularButton, "showCredits", style.txtCol, style.buttonCol, "fill"))
    table.insert(buttons, Button(xmid, ymid + 150, "Exit", fonts.regularButton, "quit", style.txtCol, style.buttonCol, "fill"))
    love.graphics.setBackgroundColor(0,0,0)

    -- Tutorial popup elements
    table.insert(tutorial_elements, Panel(xmid, ymid, xmid * 1.6, ymid * 1.2, {0.96,0.87,0.70}))
    table.insert(tutorial_elements, Text(xmid, yquart, "Use arrow keys or WASD to move the character.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(xmid, yquart + 30, "Use spacebar to start laying a net. Spread the net out and press spacebar again to place it, or ESC to cancel.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(xmid, yquart + 60, "When a bird is trapped, walk up to it and HOLD spacebar to attempt to extract it. Don't take too long or it could escape", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(xmid, yquart + 90, "Press ESC to pause.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(xmid, yquart + 120, "Score as many points as you can before the timer runs out!", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(xmid, yquart + 150, "Bird Behaviour Handbook, pp 26: 'Birds typically prefer to perch on certain tree species. Watch carefully how they move.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Text(xmid, yquart + 180, "However be cautious, when approached by humans they can become frightened (!)'.", fonts.regularText, style.txtCol))
    table.insert(tutorial_elements, Button(xmid, ymid * 1.33, "Close", fonts.regularButton, "closeTutorial", style.txtCol, {0,0,0}))
end