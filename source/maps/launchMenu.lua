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
    love.graphics.setBackgroundColor(0,0,0)
    table.insert(images, Image(xmid, ymid, "img/bg-menu-dalle.png"))
    table.insert(ui.textblocks, Text(xmid, 100, "Bird Catcher", fonts.mainTitle, style.txtCol, nil, style.buttonCol))
    table.insert(buttons, Button(xmid, ymid, "Start Game", fonts.regularButton, "gotoForest", style.txtCol, style.buttonCol, "fill"))
    table.insert(buttons, Button(xmid, ymid + 100, "Tutorial", fonts.regularButton, "showTutorial", style.txtCol, style.buttonCol, "fill"))
    -- table.insert(buttons, Button(xmid, ymid + 75, "Credits", fonts.regularButton, "showCredits", style.txtCol, style.buttonCol, "fill"))
    table.insert(buttons, Button(xmid, ymid + 200, "Exit", fonts.regularButton, "quit", style.txtCol, style.buttonCol, "fill"))

    -- Tutorial popup elements
    local tutorial_text = 
[[
Move with arrow keys or WASD 

Lay a net with spacebar. Walk to spread it and press spacebar again to place it. Use ESC to cancel.

Take a trapped bird by holding spacebar when standing at the net. Be careful, it could escape!

Press ESC to pause

Score as many points as you can before the timer runs out!


Bird Behaviour Handbook, pp 26: 
"Watch where birds perch, they may have a preferred tree type. But be cautious, when approached by humans they can become frightened (!)'
]]
    local textBoxWidth = params.gameWidth * 0.8
    table.insert(tutorial_elements, Panel(xmid, ymid, params.gameWidth * 0.9, params.gameHeight * 0.8, style.panelCol))
    table.insert(tutorial_elements, Text(xmid, params.gameHeight * 0.2, tutorial_text, fonts.regularText, style.txtCol, textBoxWidth))
    table.insert(tutorial_elements, Button(xmid, params.gameHeight * 0.8, "Close", fonts.regularButton, "closeTutorial", style.txtCol, {0,0,0}))
end