-- Parameters for a level:
local level = {
    round_time = 90,
    levelWidth = 1500,
    levelHeight = 1000,
    env = {
        bgTiles = tileset1,
        ponds = 1,
        perchTrees = 4,
        bushes = {
            bush01 = 3,
            bush02 = 3,
            bush03 = 3,
            bush04 = 3,
            bush05 = 3,
            bush06 = 3,
            bush07 = 3,
            bush08 = 3,
        },
        trees = {
            treePaintGreen01 = 10,
            treePaintGreen02 = 10,
            treePaintGreen03 = 10,
            treePaintGreen04 = 10,
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
        Spawner("BirdFlocking", "random", "random", sprites.birds.littleBrown, params.bird_speed + love.math.random(-30, 30), 5, params.bird_spawn_rate/2, 2),
        Spawner("BirdPerching", "random", "random", sprites.birds.generic, params.bird_speed + love.math.random(-30, 30), 15, params.bird_spawn_rate, 2),
        Spawner("Bird", "random", "random", sprites.birds.special, params.bird_speed * 1.5, 35, 60, 30)
    },
    initialSpawns = {
        5,1,0
    }
}

return level