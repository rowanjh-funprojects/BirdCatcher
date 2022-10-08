function createForest()
    -- Initialize entities
    player = Player(worldWidth/2, worldHeight/2, 200)
    birds = {}
    trees = {}
    panels = {}
    textblocks = {}
    spawners = {}
    score = 0

    tree_replacements_allowed = 500

    for i=1,50 do
        local x, y = find_tree_placement(trees, worldWidth, worldHeight)
        table.insert(trees, Tree(x, y, "large"))
    end
    for i=1,100 do
        local x, y = find_tree_placement(trees, worldWidth, worldHeight)
        table.insert(trees, Tree(x, y, "small"))
    end

    -- Set background
    love.graphics.setBackgroundColor(0.3,0.5,0.10)

    -- Initialize timer
    seconds = 0
    timer = cron.every(1, function() seconds = seconds + 1 end)
        
    -- Initialize spawner
    table.insert(spawners, Spawner("bird", 5, 2))

    -- Spawn initial birds
    for i=1, 5 do
        spawners[1]:spawn()
    end


end

-- trees = list of trees. x, y = candidate x/y location. n = max recursions/iterations
function find_tree_placement(trees, ww, wh)
    -- @ww = world width
    -- @wh = world height
    -- Create candidate coordinates
    local x, y = love.math.random(0,ww), love.math.random(0,wh)

    --  Break conditions
    if tree_replacements_allowed <= 0 or #trees == 0 then
        return x, y
    end
    -- Check if the placement is too close to another tree
    for i=1,#trees do
        if get_dist_rects(trees[i].x, trees[i].y, 5, 5, x, y, 5, 5) < tree_buffer then
            -- if it fails the check, find new x,y values
            tree_replacements_allowed = tree_replacements_allowed - 1
            x, y = find_tree_placement(trees)
        end
    end
    -- return the final values
    return x, y
end
