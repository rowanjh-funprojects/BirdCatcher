-- Handle all user inputs (keys, mouse clicks)
function love.keypressed(key)
    -- Space: Capture bird or place net
    if key == "space" then
        -- prioritize capturing bird
        local any_birds_capturable, nearest_capturable_bird = player:check_bird_captures()
        if any_birds_capturable then
            Player:grab_nearest_bird(nearest_capturable_bird)
        -- place net, if not already in net placement mode
        elseif not player.placing_net then
            tempNet = player:alignNet(20)
        -- if in net placement mode, finalize net placement
        elseif player.placing_net then
            -- kill the old net, place a new net
            if net then
                net:destroy()
                net = nil
            end
            net = Net(tempNet.startx, tempNet.starty, tempNet.endx, tempNet.endy)
            tempNet:destroy()
            tempNet = nil
            player.placing_net = false
        end
    end
    -- R for reset
    if key == "r" then
        love.event.quit("restart")
    end
    -- Kill net placement
    if key == "escape" and player.placing_net then
        player.placing_net = false
        tempNet:destroy()
        tempNet = nil
    end
end


function love.mousepressed(x, y, button, istouch)
    if button == 1  then
        for i=1,#buttons do
            if buttons[i].highlight then
                buttons[i]:click()
                break
            end
        end
    end
end

function checkMouseHover(entity)
    local mx = love.mouse.getX()
    local my = love.mouse.getY()
    -- check horiz overlap first
    if mx > entity.x and mx < entity.x + entity.width then
        -- then check vertical overlap
        if my > entity.y and my < entity.y + entity.height then
            return true
        end
    end
    return false
end

