function createForest()
    -- Initialize level parameters
    player_skill = 0.7
    round_time = 90
    n_perchTrees = 7
    n_trees = 100

    -- Resize world
    worldWidth = 1400
    worldHeight = 1000
    cam:setWorld(0,0,worldWidth,worldHeight)

    -- Initialize entities
    player = Player(worldWidth/2, worldHeight/2, 200)
    birds = {}
    trees = {}
    bgElements = {}
    panels = {}
    textblocks = {}
    spawners = {}
    worldEdges = {}
    makeWorldEdges()

    -- Initialize spawner
    table.insert(spawners, Spawner("BirdPerching", bird_spawn_rate, 2))
    table.insert(spawners, Spawner("BirdSpecial", 50, 20))

    -- Spawn initial birds
    for i=1, 5 do
        spawners[1]:spawnNow()
    end

    -- Create environment
    tree_replacements_allowed = 1000
    for i=1,n_trees do
        local x, y = find_tree_placement(trees, worldWidth, worldHeight)
        table.insert(trees, Tree(x, y, "small"))
    end
   for i=1,n_perchTrees do
        local x, y = find_tree_placement(trees, worldWidth, worldHeight)
        table.insert(trees, TreePerch(x, y, "large"))
    end

    -- round statistics
    score = 0
    captured_birds = 0
    escaped_birds = 0
    nets_placed = 0
    failed_extractions = 0

    -- Set background
    love.graphics.setBackgroundColor(0.3,0.5,0.10)

    -- Initialize round timer
    seconds = 0
    timer = cron.every(1, function() seconds = seconds + 1 end)
        
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
        if get_dist_points(trees[i].x, trees[i].y, x, y) < tree_buffer then
            -- if it fails the check, find new x,y values
            tree_replacements_allowed = tree_replacements_allowed - 1
            x, y = find_tree_placement(trees)
        end
    end
    -- return the final values
    return x, y
end
