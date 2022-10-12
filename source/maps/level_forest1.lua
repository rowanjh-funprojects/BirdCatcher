-- Parameters for a level:
local level = {
    round_time = 90,
    levelWidth = 1400,
    levelHeight = 1000,
    env = {
        ponds = 1,
        perchTrees = 7,
        trees = {
            treeGreenTiny = 7,
            treeGreenSmall = 7,
            treeGreenLarge = 7,
            treeGreenLargeGlow = 0,
            treeGreenLarger = 0,
            treeGreenBiggest = 7,
            treeStagSmall = 7,
            treeStagLarge = 7,
            treeYellowLarge = 0,
            treeRedSmall = 0,
        },
        rocks = {
            rockBare = 5,
            rockBareSmall = 5,
            rockBareLarge = 5,
            rockMossHuge = 2,
            rockMoss = 5
        }
    },
    spawners = {
        Spawner("BirdPerching", "random", "random", sprites.birds.littleBrown, params.bird_speed, 5, params.bird_spawn_rate*2, 2),
        Spawner("BirdPerching", "random", "random", sprites.birds.generic, params.bird_speed, 10, params.bird_spawn_rate*2, 2),
        Spawner("Bird", "random", "random", sprites.birds.special, params.bird_speed * 1.5, 10, 60, 30)
    },
    initialSpawns = {
        5,1,0
    }
}

return level