function roundEnd()
    local xWinCentre = params.winWidth/2
    local yWinCentre = params.winHeight/2
    if score > globals.high_score then
        globals.high_score = score
    end
    
    table.insert(ui.panels, Panel(xWinCentre, yWinCentre, xWinCentre, yWinCentre))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 140, "Round Over", fonts.regularButton, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 90, "Score: " .. score, fonts.regularText, {0,0,0}))
    
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre - 20, "Captured Birds: ".. captured_birds, fonts.regularText, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre, "Failed Net Extractions: " .. failed_extractions, fonts.regularText, {0,0,0}))
    table.insert(ui.textblocks, Text(xWinCentre, yWinCentre + 20, "Nets placed: " .. nets_placed, fonts.regularText, {0,0,0}))
    
    table.insert(buttons, Button(xWinCentre - 130, yWinCentre + 120, "Try again" , fonts.regularButton, "restart", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xWinCentre + 130, yWinCentre + 120, "Main Menu" , fonts.regularButton, "menu", {0,0,0}, {0,0,0}))
end