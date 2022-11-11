function roundEnd()
    local xmid = params.gameWidth/2
    local ymid = params.gameHeight/2
    if score > globals.high_score then
        globals.high_score = score
    end
    
    table.insert(ui.panels, Panel(xmid, ymid, xmid * 1.5, ymid * 1.5, style.panelCol))
    table.insert(ui.textblocks, Text(xmid, ymid - ymid*0.5, "Round Over", fonts.regularButton, {0,0,0}))
    table.insert(ui.textblocks, Text(xmid, ymid - ymid*0.35, "Score: " .. score, fonts.regularText, {0,0,0}))
    
    table.insert(ui.textblocks, Text(xmid, ymid - 50, "Captured Birds: ".. captured_birds, fonts.regularText, {0,0,0}))
    table.insert(ui.textblocks, Text(xmid, ymid, "Failed Net Extractions: " .. failed_extractions, fonts.regularText, {0,0,0}))
    table.insert(ui.textblocks, Text(xmid, ymid + 50, "Nets placed: " .. nets_placed, fonts.regularText, {0,0,0}))
    
    table.insert(buttons, Button(xmid - 160, ymid + ymid*0.5, "Try again" , fonts.regularButton, "restart", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xmid + 160, ymid + ymid*0.5, "Main Menu" , fonts.regularButton, "menu", {0,0,0}, {0,0,0}))
end