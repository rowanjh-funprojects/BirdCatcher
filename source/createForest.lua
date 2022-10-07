function createForest()
    -- Initialize entities
    player = Player(100, 100, 200)
    birds = {}
    trees = {}

    tree_replacements_allowed = 500
    for i=1,50 do
        local x, y = find_tree_placement(trees)
        table.insert(trees, Tree(x, y, "small"))
    end
    for i=1,30 do
        local x, y = find_tree_placement(trees)
        table.insert(trees, Tree(x, y, "large"))
    end
    love.graphics.setBackgroundColor(0.3,0.5,0.10)

end

-- trees = list of trees. x, y = candidate x/y location. n = max recursions/iterations
function find_tree_placement(trees)
    -- Create candidate coordinates
    local x, y = love.math.random(0,windowWidth), love.math.random(0,windowHeight)

    --  Break conditions
    if tree_replacements_allowed <= 0 or #trees == 0 then
        return x, y
    end
    -- Check if the placement is too close to another tree
    for i=1,#trees do
        if get_dist_points(trees[i].x, trees[i].y, 5, 5, x, y, 5, 5) < tree_buffer then
            -- if it fails the check, find new x,y values
            tree_replacements_allowed = tree_replacements_allowed - 1
            x, y = find_tree_placement(trees)
        end
    end
    -- return the final values
    return x, y
end
