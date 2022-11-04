-- Handle all user inputs (keys, mouse clicks)
function love.keypressed(key)
    if not (globals.gamestate == "forest") then
        -- No keyboard except in gameplay
        return
    end
    -- Space: Capture bird or place net
    if key == "space" then
        -- prioritize capturing bird
        local any_birds_capturable, nearest_capturable_bird = player:check_bird_captures()
        if any_birds_capturable then
            player:startExtractionAttempt(nearest_capturable_bird)
            -- Kill net if in the middle of placement
            if netTemp then
                netTemp:destroy()
                netTemp = nil
                player.placing_net = false
            end
        -- place net, if not already in net placement mode
        elseif not player.placing_net then
            netTemp = player:alignNet(params.net_max_length)
        -- if in net placement mode, finalize net placement
        elseif player.placing_net then
            -- kill the oldest net, place a new net
            if #nets == params.player_nets_allowed then
                nets[1]:destroy()
            end
            table.insert(nets, NetPlaced(netTemp.startx, netTemp.starty, netTemp.endx, netTemp.endy))
            netTemp:destroy()
            netTemp = nil
            player.placing_net = false
        end
    end
    -- R for reset
    if key == "r" then
        love.event.quit("restart")
    end
    -- Kill net placement
    if (key == "escape" or key == "x") and player.placing_net then
        player.placing_net = false
        netTemp:destroy()
        netTemp = nil
    elseif (key == "escape" or key == "x") and player.teleporting then
        player.teleporting = false
        player.immobilized = false
    elseif key == "escape" and not globals.paused then
        globals.paused = true
        showPauseScreen()
    elseif key == "escape" and globals.paused then
        globals.paused = false
        tag_as_destoyed(buttons)
        remove_if_destroyed(buttons)    
        tag_as_destoyed(ui.panels)
        remove_if_destroyed(ui.panels)    
        tag_as_destoyed(ui.textblocks)
        remove_if_destroyed(ui.textblocks)    
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1  then
        if show_tutorial then
            -- check for tutorial window first to give close button 
            -- priority over other buttons
            for i=1, #tutorial_elements do
                if tutorial_elements[i]:is(Button) then
                    if tutorial_elements[i].highlight then
                        tutorial_elements[i]:click()
                        return
                    end
                end
            end
        end
        for i=1,#buttons do
            if buttons[i].highlight then
                buttons[i]:click()
                return
            end
        end
    elseif button == 2 then
        if player.canTeleport then
            player:initTpSequence(x, y)
        end
    end
end

function checkMouseHover(entity)
    local mx = love.mouse.getX()
    local my = love.mouse.getY()
    -- check horiz overlap first
    if mx > entity.x - (entity.width / 2) and mx < entity.x + (entity.width / 2) then
        -- then check vertical overlap
        if my > (entity.y - entity.height / 2) and my < entity.y + (entity.height / 2) then
            return true
        end
    end
    return false
end

