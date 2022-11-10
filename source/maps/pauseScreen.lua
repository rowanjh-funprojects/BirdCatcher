function showPauseScreen()
    local xmid = params.gameWidth/2
    local ymid = params.gameHeight/2
    
    table.insert(ui.panels, Panel(xmid, ymid, xmid * 1.5, ymid * 1.5, style.panelCol))
    table.insert(ui.textblocks, Text(xmid, ymid - ymid*0.5, "Paused", fonts.regularButton, {0,0,0}))
    table.insert(ui.textblocks, Text(xmid, ymid - 90, "Score: " .. score, fonts.regularText, {0,0,0}))
    
    table.insert(ui.textblocks, Text(xmid, ymid - 50, "Captured Birds: ".. captured_birds, fonts.regularText, {0,0,0}))
    table.insert(ui.textblocks, Text(xmid, ymid, "Failed Net Extractions: " .. failed_extractions, fonts.regularText, {0,0,0}))
    table.insert(ui.textblocks, Text(xmid, ymid + 50, "Nets placed: " .. nets_placed, fonts.regularText, {0,0,0}))
    
    table.insert(buttons, Button(xmid - xmid*0.4, ymid + ymid*0.5, "Resume" , fonts.regularButton, "resume", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xmid, ymid + ymid*0.5, "Restart" , fonts.regularButton, "restart", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xmid + xmid*0.4, ymid + ymid*0.5, "Main Menu" , fonts.regularButton, "menu", {0,0,0}, {0,0,0}))
end