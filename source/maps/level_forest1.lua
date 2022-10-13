-- Parameters for a level:
local level = {
    round_time = 90,
    levelWidth = 1400,
    levelHeight = 1000,
    env = {
        ponds = 2,
        perchTrees = 5,
        trees = {
            -- treeGreenTiny = 30,
            -- treeGreenSmall = 25,
            -- treeGreenLarge = 0,
            -- treeGreenLargeGlow = 0,
            -- treeGreenLarger = 0,
            -- treeGreenBiggest = 0,
            -- treeStagSmall = 3,
            -- treeStagLarge = 3,
            -- treeYellowLarge = 0,
            -- treeRedSmall = 0,
            treePaintGreen01 = 5,
            treePaintGreen02 = 5,
            treePaintGreen03 = 5,
            treePaintGreen04 = 5,
            treePaintOrange01 = 1,
            treePaintOrange02 = 1,
            treePaintOrange03 = 1,
            treePaintOrange04 = 1,
            treePaintStag01 = 3,
            treePaintStag02 = 3,
            treePaintYellow01 = 1,
            treePaintYellow02 = 1,
        },
        rocks = {
            rockBare = 5,
            rockBareSmall = 5,
            rockBareLarge = 5,
            rockMossHuge = 2,
            rockMoss = 5,
            rockStump = 2,
        }
    },
    spawners = {
        Spawner("BirdPerching", "random", "random", sprites.birds.littleBrown, params.bird_speed, 5, params.bird_spawn_rate*2, 2),
        Spawner("BirdPerching", "random", "random", sprites.birds.generic, params.bird_speed, 10, params.bird_spawn_rate*2, 2),
        Spawner("Bird", "random", "random", sprites.birds.special, params.bird_speed * 1.75, 25, 60, 30)
    },
    initialSpawns = {
        5,1,0
    }
}

return level