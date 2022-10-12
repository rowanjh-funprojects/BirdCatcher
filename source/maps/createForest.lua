function createForest()
    -- Initialize level parameters
    params.player_skill = 0.7
    round_time = 90
    n_perchTrees = 7
    n_trees = 100
    n_biggestTrees = 7

    -- Resize world
    params.worldWidth = 1400
    params.worldHeight = 1000
    cam:setWorld(0,0,params.worldWidth,params.worldHeight)

    -- Initialize entities
    player = Player(params.worldWidth/2, params.worldHeight/2, 200)
    birds = {}
    spawners = {}
    env = {}
    env.trees = {}
    env.bgElements = {}
    env.worldEdges = {}

    ui = {}
    ui.panels = {}
    ui.textblocks = {}
    makeWorldEdges()

    -- Initialize spawner
    table.insert(spawners, Spawner("BirdLittleBrown", params.bird_spawn_rate*2, 2))
    table.insert(spawners, Spawner("BirdPerching", params.bird_spawn_rate*2, 8))
    table.insert(spawners, Spawner("BirdSpecial", 60, 30))

    -- Spawn initial birds
    for i=1, 5 do
        spawners[1]:spawnNow()
    end
    spawners[2]:spawnNow()


    -- Create environment

    -- Trees
    params.tree_replacements_allowed = 1000

    local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
    table.insert(env.trees, Tree(x, y, sprites.env.pond))

    for i=1,3 do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.rockBare))
    end
    for i=1,7 do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.rockBareSmall))
    end
    for i=1,3 do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.rockBareLarge))
    end
    for i=1,2 do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.rockMossHuge))
    end
    for i=1,3 do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.rockMoss))
    end

    for i=1,n_biggestTrees do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.treeGreenBiggest))
    end
    for i=1,n_trees do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.treeGreenTiny))
    end
    for i=1,5 do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.treeStagLarge))
    end
    for i=1,5 do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, Tree(x, y, sprites.env.treeStagSmall))
    end
    for i=1,n_perchTrees do
        local x, y = find_tree_placement(env.trees, params.worldWidth, params.worldHeight)
        table.insert(env.trees, TreePerch(x, y, sprites.env.treeYellowLarge))
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
    if params.tree_replacements_allowed <= 0 or #env.trees == 0 then
        return x, y
    end
    -- Check if the placement is too close to another tree
    for i=1,#env.trees do
        if get_dist_points(env.trees[i].x, env.trees[i].y, x, y) < params.tree_buffer then
            -- if it fails the check, find new x,y values
            params.tree_replacements_allowed = params.tree_replacements_allowed - 1
            x, y = find_tree_placement(env.trees)
        end
    end
    -- return the final values
    return x, y
end
