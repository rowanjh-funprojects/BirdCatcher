function roundEnd()
    local xWinCentre = windowWidth/2
    local yWinCentre = windowHeight/2
    table.insert(panels, Panel(xWinCentre, yWinCentre, xWinCentre, yWinCentre))
    table.insert(textblocks, Text(xWinCentre, yWinCentre - 140, "Round Over", 3, {0,0,0}))
    table.insert(textblocks, Text(xWinCentre, yWinCentre - 90, "Score: " .. score, 3, {0,0,0}))
    table.insert(buttons, Button(xWinCentre - 130, yWinCentre + 120, "Try again" , 3, "restart", {0,0,0}, {0,0,0}))
    table.insert(buttons, Button(xWinCentre + 130, yWinCentre + 120, "Main Menu" , 3, "menu", {0,0,0}, {0,0,0}))
end