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
    a_left = a.x - a.spriteWidth * sa / 2
    a_right = a.x + a.spriteWidth * sa / 2
    a_top = a.y - a.spriteHeight * sa / 2
    a_bottom = a.y + a.spriteHeight * sa / 2

    local b_left, b_right, b_top, b_bottom
    b_left = b.x - b.spriteWidth * sb / 2
    b_right = b.x + b.spriteWidth * sb / 2
    b_top = b.y + b.spriteHeight * sb / 2
    b_bottom = b.y - b.spriteHeight * sb / 2

    -- Check if two objects intersect each other
    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
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
    tag_as_destoyed(trees)
    remove_if_destroyed(trees)
    tag_as_destoyed(bgElements)
    remove_if_destroyed(bgElements)
    tag_as_destoyed(panels)
    remove_if_destroyed(panels)
    tag_as_destoyed(textblocks)
    remove_if_destroyed(textblocks)
    tag_as_destoyed(worldEdges)
    remove_if_destroyed(worldEdges)

    if player then
        player:destroy()
        player = nil
    end
    if tempNet then
        tempNet:destroy()
        tempNet = nil
    end
    if net then
        net:destroy()
        net = nil
    end

end

function makeWorldEdges()
    table.insert(worldEdges, WorldEdge(-10, 0, 10, worldHeight)) -- left
    table.insert(worldEdges, WorldEdge(worldWidth + 1, 0, 10, worldHeight)) -- right
    table.insert(worldEdges, WorldEdge(0, -10, worldWidth, 10)) -- top
    table.insert(worldEdges, WorldEdge(0, worldHeight + 1, worldWidth, 10)) -- bot
end

function getOffscreenDestination()
    return x, y
end