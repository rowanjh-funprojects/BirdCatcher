function gameplayUpdate(dt)
    cam:setPosition(player.x, player.y)

    timer:update(dt)
    -- Player update
    player:update(dt)
    if player.placing_net then
        tempNet:update(dt, player)
    end
    -- Bird update
    for i,v in ipairs(birds) do
        v:update(dt)
    end
    -- Tree update
    for i,v in ipairs(env.trees) do
        v:update(dt)
    end
    -- environment update
    for i,v in ipairs(env.bgElements) do
        v:update(dt)
    end
    -- Spawners update
    for i,v in ipairs(spawners) do
        v:update(dt)
    end

    remove_if_destroyed(birds)
    remove_if_destroyed(env.trees)
    remove_if_destroyed(env.bgElements)
    remove_if_destroyed(ui.textblocks)
    remove_if_destroyed(ui.panels)
    remove_if_destroyed(buttons)

    if seconds >= round_time then
        globals.roundEnd = true
        globals.paused = true
        roundEnd() -- creates round end buttons/panels/text
    end
end