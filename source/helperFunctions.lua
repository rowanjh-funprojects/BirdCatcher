function get_dist(obj_a, obj_b)
    -- Get distance between two objects. each object Must have .x and .y attributes
    -- get middles of each object
    local a_x, a_y = obj_a.x + obj_a.width / 2, obj_a.y + obj_a.height/2
    local b_x, b_y = obj_b.x + obj_b.width / 2, obj_b.y + obj_b.height/2
    return ((a_x - b_x)^2 + (a_y - b_y)^2)^0.5
end

function get_dist_points(ax, ay, aw, ah, bx, by, bw, bh)
    -- Get distance between two objects. each object Must have .x and .y attributes
    -- get middles of each object
    local ax_mid, ay_mid = ax + aw / 2, ay + ah / 2
    local bx_mid, by_mid = bx + bw / 2, by + bh / 2
    return ((ax_mid - bx_mid)^2 + (ay_mid - by_mid)^2)^0.5
end


function remove_destroyed_items(tbl)
    for i=#tbl,1,-1 do
        if tbl[i].destroyed then
            table.remove(tbl, i)
        end
    end
end

