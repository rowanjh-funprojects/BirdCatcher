function showPauseScreen()
    local xWinCentre = params.worldWidth/2
    local yWinCentre = params.worldHeight/2
    
    table.insert(ui.panels, Panel(xWinCentre, yWinCentre, xWinCentre, yWinCentre))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 140, "Paused", fonts.regularButton, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 90, "Score: " .. score, fonts.regularText, {0,0,0}))
    
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 20, "Captured Birds: ".. captured_birds, fonts.regularText, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre, "Failed Net Extractions: " .. failed_extractions, fonts.regularText, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre + 20, "Nets placed: " .. nets_placed, fonts.regularText, {0,0,0}))
    
    table.insert(buttons, Button(xWinCentre - 220, yWinCentre + 120, "Resume" , fonts.regularButton, "resume", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xWinCentre-20, yWinCentre + 120, "Restart" , fonts.regularButton, "restart", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xWinCentre + 210, yWinCentre + 120, "Main Menu" , fonts.regularButton, "menu", {0,0,0}, {0,0,0}))
end