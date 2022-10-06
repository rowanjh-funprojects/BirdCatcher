-- Handle all user inputs (keys, mouse clicks)
function love.keypressed(key)
    if key == "space" then
        -- prioritize capturing bird
        local any_birds_capturable, nearest_capturable_bird = player:check_bird_captures()
        if any_birds_capturable then
            Player:grab_nearest_bird(nearest_capturable_bird)
        -- place net, if not already in net placement mode
        elseif not player.placing_net then
            tempNet = player:alignNet(20)
            player.placing_net = true
        -- if in net placement mode, finalize net placement
        elseif player.placing_net then
            -- kill old netTiles
            killOldNet()
            net, netTiles = tempNet:confirmNet()
            player.placing_net = false
        end
    end
end