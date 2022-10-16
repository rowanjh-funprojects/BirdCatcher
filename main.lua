local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"

    if launch_type == "debug" then
        lldebugger.start()
    end
end

function love.load()
    require "source/startup"
    startup()
    globals.gamestate = "menu"
    launchLevel(globals.gamestate)
end

function love.update(dt)
    if globals.gamestate == "menu" then
        if show_tutorial then
            for i = 1, #tutorial_elements do
                tutorial_elements[i]:update()
            end
        else
            for i=1,#buttons do
                buttons[i]:update()
            end
        end
    elseif globals.gamestate == "forest" and not globals.paused then
        -- handles main game updates
        gameplayUpdate(dt)
    elseif globals.gamestate == "forest" and globals.paused then
        -- Buttons update
        for i,v in ipairs(buttons) do
            v:update(dt)
        end
    end
end

function love.draw()
    if globals.gamestate == "menu" then
        for i=1,#images do
            images[i]:draw()
        end
        for i=1,#ui.panels do
            ui.panels[i]:draw()
        end
        for i=1,#buttons do
            buttons[i]:draw()
        end
        for i=1,#ui.textblocks do
            ui.textblocks[i]:draw()
        end
        if show_tutorial then
            for i = 1, #tutorial_elements do
                tutorial_elements[i]:draw()
            end
        end
    elseif globals.gamestate == "forest" then
        gameplayDraw()
    end
    -- drawDebugGrid()

end

local love_errorhandler = love.errhand
function love.errorhandler(msg)
    if lldebugger then
        lldebugger.start() -- Add this
         error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end