function get_dist_objs(a, b)
    -- Get distance between two objects. each object Must have .x and .y attributes
    -- get middles of each object
    return get_dist_points(a.x, a.y, b.x, b.y)
end

function get_dist_points(ax, ay, bx, by)
    -- Get distance between two points
    return ((ax - bx)^2 + (ay - by)^2)^0.5
end

function spriteIntersects(a, b, sa, sb)
    -- @a, b sprite objects
    -- @sa scale for object a
    -- @sb scale for object b
    -- scales add a positive or negative buffer around sprite before checking for intersection
    -- (i.e. making the sprite collision square smaller or bigger)
    local a_left, a_right, a_top, a_bottom
    a_left = a.x - a.sprite.width * sa / 2
    a_right = a.x + a.sprite.width * sa / 2
    a_top = a.y - a.sprite.height * sa / 2
    a_bottom = a.y + a.sprite.height * sa / 2

    local b_left, b_right, b_top, b_bottom
    b_left = b.x - b.sprite.width * sb / 2
    b_right = b.x + b.sprite.width * sb / 2
    b_top = b.y - b.sprite.height * sb / 2
    b_bottom = b.y + b.sprite.height * sb / 2

    -- Check if two objects intersect each other

    return a_left < b_right and a_right > b_left and a_top < b_bottom and a_bottom > b_top
end

function remove_if_destroyed(tbl)
    -- Handles a table of objects, and or empty table
    local next = next -- makes next a bit more efficient
    if not tbl then 
        return -- if obj doesn't exist, end
    elseif next(tbl) == nil then 
        return -- if empty table is given, end
    elseif #tbl > 0 then
        -- If a table of objects is given, loop through them and remove each destroyed item
        for i=#tbl,1,-1 do
            if tbl[i].destroyed then
                table.remove(tbl, i)
            end
        end
    end
end

function tag_as_destoyed(tbl)
    -- Handles a table of objects, and or empty table
    local next = next -- makes next a bit more efficient
    if not tbl then 
        return -- if obj doesn't exist, end
    elseif next(tbl) == nil then
        return -- if empty table is given, end
    elseif #tbl > 0 then
        -- If a table of objects is given, loop through them and destroy each item
        for i=#tbl,1,-1 do
            tbl[i]:destroy()
        end
    end
end

function destroyAll()
    tag_as_destoyed(buttons)
    remove_if_destroyed(buttons)
    tag_as_destoyed(birds)
    remove_if_destroyed(birds)
    tag_as_destoyed(flocks)
    remove_if_destroyed(flocks)
    tag_as_destoyed(env.trees)
    remove_if_destroyed(env.trees)
    tag_as_destoyed(env.bgElements)
    remove_if_destroyed(env.bgElements)
    tag_as_destoyed(ui.panels)
    remove_if_destroyed(ui.panels)
    tag_as_destoyed(ui.textblocks)
    remove_if_destroyed(ui.textblocks)
    tag_as_destoyed(env.worldEdges)
    remove_if_destroyed(env.worldEdges)

    if player then
        player:destroy()
        player = nil
    end
    if netTemp then
        netTemp:destroy()
        netTemp = nil
    end
    if net then
        net:destroy()
        net = nil
    end

end

function makeWorldEdges()
    table.insert(env.worldEdges, WorldEdge(-10, 0, 10, params.worldHeight)) -- left
    table.insert(env.worldEdges, WorldEdge(params.worldWidth + 1, 0, 10, params.worldHeight)) -- right
    table.insert(env.worldEdges, WorldEdge(0, -10, params.worldWidth, 10)) -- top
    table.insert(env.worldEdges, WorldEdge(0, params.worldHeight + 1, params.worldWidth, 10)) -- bot
end

function getOffscreenPoint()
    --- Get a random point that is just off the edge of the screen for a, for
    --- immigration and emigration.
    local edge = love.math.random(1,4)
    local x, y
    if edge == 1 then -- top
        x = love.math.random(0,params.worldWidth)
        y = -200
    elseif edge == 2 then --right
        x = params.worldWidth + 200
        y = love.math.random(0,params.worldHeight)
    elseif edge == 3 then --bottom
        x = love.math.random(0,params.worldWidth)
        y = params.worldHeight + 200
    else --left
        x = -200
        y = love.math.random(0,params.worldHeight)
    end
    return x, y
end

function prepSprite(img, nRows, nCols, rate, ...)
    --- @... frame specification for anim8.newAnimation(g(...))
    local sprite = {}
    sprite.image = love.graphics.newImage(img)
    sprite.width = math.floor(sprite.image:getWidth() / nCols)
    sprite.height = math.floor(sprite.image:getHeight() / nRows)
    sprite.animated = nRows > 1 or nCols > 1
    if sprite.animated then
        local g = anim8.newGrid(sprite.width, sprite.height, 
                                sprite.width * nCols, sprite.height * nRows)
        sprite.animation = anim8.newAnimation(g(...), rate)
    end
    sprite.drawOffsetX = sprite.width / 2
    sprite.drawOffsetY = sprite.height / 2
    return sprite
end

-- Save copied tables in `copies`, indexed by original table.
function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
            end
            setmetatable(copy, deepcopy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

