function get_dist_objs(a, b)
    -- Get distance between two objects. each object Must have .x and .y attributes
    -- get middles of each object
    return get_dist_rects(a.x, a.y, a.width, a.height, b.x, b.y, b.width, b.height)
end

function get_dist_rects(ax, ay, aw, ah, bx, by, bw, bh)
    -- Get distance between two rectangles
    local ax_mid = ax + aw / 2
    local ay_mid = ay + ah / 2
    local bx_mid = bx + bw / 2
    local by_mid = by + bh / 2
    return get_dist_points(ax_mid, ay_mid, bx_mid, by_mid)
end

function get_dist_points(ax, ay, bx, by)
    -- Get distance between two points
    return ((ax - bx)^2 + (ay - by)^2)^0.5
end

function intersects(a, b, sa, sb)
    -- @a, b box objects
    -- @sa scale for object a
    -- @sb scale for object b
    -- scales add a buffer around box before checking for intersection
    -- (proportion e.g. 2 = double width, 0.5 = half width)
    -- Buffer holds centre of the image stationary (see rescale_box)
    local a_left, a_right, a_top, a_bottom
    local b_left, b_right, b_top, b_bottom
    if not sa then 
        a_left = a.x
        a_right = a.x + a.width
        a_top = a.y
        a_bottom = a.y + a.height
    else
        -- get rescaled values
        local ax_r, ay_r, aw_r, ah_r = rescale_box(a, sa)
        a_left = ax_r
        a_right = ax_r + aw_r
        a_top = ay_r
        a_bottom = ay_r + ah_r
    end

    if not sb then
        b_left = b.x
        b_right = b.x + b.width
        b_top = b.y
        b_bottom = b.y + b.height
    else
        -- get rescaled values
        local bx_r, by_r, bw_r, bh_r = rescale_box(b, sb)
        b_left = bx_r
        b_right = bx_r + bw_r
        b_top = by_r
        b_bottom = by_r + bh_r
    end
    -- Check if two objects intersect each other
    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
end

function rescale_box(obj, scale)
    -- Take a box in physical space, and get a re-scaled x,y,w,h. 
    -- Keep the center of the object in the same place
    local x, y, w, h = obj.x, obj.y, obj.width, obj.height
    local new_w = w * scale
    local new_h = h * scale

    local new_x = x - (new_w - w)/2
    local new_y = y - (new_h - h)/2
    return new_x, new_y, new_w, new_h
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