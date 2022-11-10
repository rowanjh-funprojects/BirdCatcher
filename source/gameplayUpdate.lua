function gameplayUpdate(dt)
    -- update camera position
    local camX, camY = cam:getPosition()
    if camX ~= player.x or camY ~= player.y then
        -- pan camera when there is a sudden jump
        local newCamX = camX - (camX - player.x) * dt * 2
        local newCamY = camY - (camY - player.y) * dt * 2
        cam:setPosition(newCamX, newCamY)
    end

    timer:update(dt)
    -- Player update
    player:update(dt)
    if player.placing_net then
        netTemp:update(dt, player)
    end
    -- Bird update
    for i,v in ipairs(birds) do
        v:update(dt)
    end
    for i,v in ipairs(flocks) do
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
    remove_if_destroyed(nets)
    remove_if_destroyed(flocks)
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