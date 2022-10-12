-- Create an environment with given parameters
function generateLevel(spec)
    -- get level parameters
    -- Initialize level parameters
    params.player_skill = 0.7
    round_time = spec.round_time
    tree_placement_attempts = 1000

    -- Resize world
    params.worldWidth = spec.levelWidth
    params.worldHeight = spec.levelHeight   
    cam:setWorld(0,0,spec.levelWidth, spec.levelHeight)

    -- Initialize entities
    player = Player(params.worldWidth/2, params.worldHeight/2, sprites.player)
    birds = {}
    spawners = {}
    env = {}
    env.trees = {}
    env.rocks = {}
    env.bgElements = {}
    env.worldEdges = {}

    ui = {}
    ui.panels = {}
    ui.textblocks = {}
    makeWorldEdges()

    for i=1, #spec.spawners do
        table.insert(spawners, spec.spawners[i])
    end


    -- Spawn initial birds
    for i=1, #spec.spawners do
        if spec.initialSpawns[i] > 0 then
            for j=1, spec.initialSpawns[i] do
                spec.spawners[i]:spawnNow()
            end
        end
    end

    -- Create environment
    -- Pond(s)
    if spec.env.ponds > 0 then
        for i=1, spec.env.ponds do
            local pondx = love.math.random(sprites.env.pond.width / 2, params.worldWidth - (sprites.env.pond.width / 2))
            local pondy = love.math.random(sprites.env.pond.height / 2, params.worldHeight - (sprites.env.pond.height / 2))
            local pond = Pond(pondx, pondy, sprites.env.pond)
            table.insert(env.bgElements, pond)
            pond:addToWorld()
        end
    end
    
    for k,v in pairs(spec.env.rocks) do  
        if v > 0 then
            for i=1,v do
                local rock = place_obj(Rock(200, 200, sprites.env[k]), env.bgElements)
                if rock then
                    table.insert(env.rocks, rock)
                    rock:addToWorld()
                end
            end   
        end
    end
    for i=1,spec.env.perchTrees do
        local perchTree = place_obj(TreePerch(200, 200, sprites.env.treeYellowLarge), env.trees)
        if perchTree then
            table.insert(env.trees, perchTree)
            perchTree:addToWorld()
        end
    end
    for k,v in pairs(spec.env.trees) do
        if v > 0 then
            for i=1,v do
                local tree = place_obj(Tree(200, 200, sprites.env[k]), env.bgElements, env.trees)
                if tree then
                    table.insert(env.trees, tree)
                    tree:addToWorld()
                end
            end
        end
    end
    
    -- round statistics
    score = 0
    captured_birds = 0
    escaped_birds = 0
    nets_placed = 0
    failed_extractions = 0

    -- Initialize round timer
    seconds = 0
    timer = cron.every(1, function() seconds = seconds + 1 end)
        
end

function place_obj(thisObj, mustAvoid, otherTrees)
    --- @obj = the sprite to be placed
    --- @mustAvoid = a list of objects that cannot be overlapped (e.g. ponds)
    --- @otherTrees = a list of objects that will try to be avoided, but it will get 
    ---               placed anyway if a perfect spot is not found. Can be omitted
    -- Break condition if no placement was possible
    if tree_placement_attempts <= 0 then
        return
    end

    -- First avoid and "must avoid" objects, or else give up
    local bad_placement = true
    local attempts=0
    if #mustAvoid == 0 then
        bad_placement = false
    end

    while bad_placement and attempts<1000 do
        thisObj.x = love.math.random(thisObj.sprite.width/2, params.worldWidth - thisObj.sprite.width/2)
        thisObj.y = love.math.random(thisObj.sprite.height/2, params.worldHeight - thisObj.sprite.height/2)
        -- check for overlap 
        local clash = false
        for i=1, #mustAvoid do
            if spriteIntersects(thisObj, mustAvoid[i], 1, 1) then
                clash = true
                -- break the for loop
                break
            end
        end
        if clash then
            attempts = attempts + 1
        else
            bad_placement = false
        end
    end

    if bad_placement then
        return -- return without placing the object due to the clash
    end
    -- if the other trees arg is not given at all, then don't attempt to avoid trees, only 
    -- avoid the main obstacles
    if not otherTrees then
        return thisObj
    end
    -- Then try to avoid other trees
    -- If no other trees, coords are good.
    if #otherTrees == 0 then
        return thisObj
    end
    
    -- Check if the placement is too close to another tree
    local clash = false
    for i=1,#otherTrees do
        if get_dist_points(otherTrees[i].x, otherTrees[i].y, thisObj.x, thisObj.y) < params.tree_buffer then
            clash = true
            break
        end
    end

    -- If too close to another tree, then get new coordinates and try another spot
    if clash then
        tree_placement_attempts = tree_placement_attempts-1
        thisObj = place_obj(thisObj, mustAvoid, otherTrees)
    end
    -- Return the final result, be it a tree or nil.
    return thisObj
end
