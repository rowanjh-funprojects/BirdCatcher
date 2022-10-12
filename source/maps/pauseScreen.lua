function showPauseScreen()
    local xWinCentre = params.worldWidth/2
    local yWinCentre = params.worldHeight/2
    
    table.insert(ui.panels, Panel(xWinCentre, yWinCentre, xWinCentre, yWinCentre))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 140, "Paused", 3, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 90, "Score: " .. score, 3, {0,0,0}))
    
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 20, "Captured Birds: ".. captured_birds, 1, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre, "Failed Net Extractions: " .. failed_extractions, 1, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre + 20, "Nets placed: " .. nets_placed, 1, {0,0,0}))
    
    table.insert(buttons, Button(xWinCentre - 130, yWinCentre + 120, "Resume" , 3, "resume", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xWinCentre - 130, yWinCentre + 120, "Restart" , 3, "restart", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xWinCentre + 130, yWinCentre + 120, "Main Menu" , 3, "menu", {0,0,0}, {0,0,0}))
end