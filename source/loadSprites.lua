-- Load raw images
sprites = {}

sprites.player = prepSprite("img/player_down walk.png", 2, 4, 0.1, '1-4',1)

sprites.birds = {}
sprites.birds.generic = prepSprite("img/bird2blue_0.10_fixed.png", 3, 3, 0.1,'1-3','1-3')
sprites.birds.special = prepSprite("img/parrot-60px.png", 4, 4, 0.1,'1-4', '1-2')
sprites.birds.littleBrown = prepSprite("img/little-brown-bird-30px-browner.png", 2, 2, 0.1, 1,1, 2,1, 1,2, 2,2, 1,2, 2,1)

sprites.env = {}
sprites.env.treeGreenTiny = prepSprite("img/green-tree-tiny.png", 1, 1)
sprites.env.treeGreenSmall = prepSprite("img/green-tree-small.png", 1, 1)
sprites.env.treeGreenLarge = prepSprite("img/green-tree-large.png", 1, 1)
sprites.env.treeGreenLargeGlow = prepSprite("img/green-tree-large-glow.png", 1, 1)
sprites.env.treeGreenLarger = prepSprite("img/green-tree-larger.png", 1, 1)
sprites.env.treeGreenBiggest = prepSprite("img/green-tree-biggest.png", 1, 1)
sprites.env.treeStagSmall = prepSprite("img/stag-small.png", 1, 1)
sprites.env.treeStagLarge = prepSprite("img/stag-large.png", 1, 1)
sprites.env.treeYellowLarge = prepSprite("img/yellow-tree-large.png", 1, 1)
sprites.env.treeRedSmall = prepSprite("img/red-tree-small.png", 1, 1)

sprites.env.treePaintGreen01 = prepSprite("img/painted-trees/green-01.png", 1, 1)
sprites.env.treePaintGreen02 = prepSprite("img/painted-trees/green-02.png", 1, 1)
sprites.env.treePaintGreen03 = prepSprite("img/painted-trees/green-03.png", 1, 1)
sprites.env.treePaintGreen04 = prepSprite("img/painted-trees/green-04.png", 1, 1)
sprites.env.treePaintOrange01 = prepSprite("img/painted-trees/orange-01.png", 1, 1)
sprites.env.treePaintOrange02 = prepSprite("img/painted-trees/orange-02.png", 1, 1)
sprites.env.treePaintOrange03 = prepSprite("img/painted-trees/orange-03.png", 1, 1)
sprites.env.treePaintOrange04 = prepSprite("img/painted-trees/orange-04.png", 1, 1)
sprites.env.treePaintStag01 = prepSprite("img/painted-trees/stag-01.png", 1, 1)
sprites.env.treePaintStag02 = prepSprite("img/painted-trees/stag-02.png", 1, 1)
sprites.env.treePaintStag03 = prepSprite("img/painted-trees/stag-03.png", 1, 1)
sprites.env.treePaintYellow01 = prepSprite("img/painted-trees/yellow-01.png", 1, 1)
sprites.env.treePaintYellow02 = prepSprite("img/painted-trees/yellow-02.png", 1, 1)
sprites.env.treePaintPurple01 = prepSprite("img/painted-trees/purple-01.png", 1, 1)



sprites.env.rockBare = prepSprite("img/rock-bare-1.png", 1, 1)
sprites.env.rockBareSmall = prepSprite("img/rock-bare-small-1.png", 1, 1)
sprites.env.rockBareLarge = prepSprite("img/rock-bare-large-1.png", 1, 1)
sprites.env.rockMossHuge = prepSprite("img/rock-moss-huge-1.png", 1, 1)
sprites.env.rockMoss = prepSprite("img/rock-moss-1.png", 1, 1)
sprites.env.rockStump = prepSprite("img/painted-trees/stump-01.png", 1, 1)
-- sprites.env.pond = prepSprite("img/pond-01.png", 1, 1)
sprites.env.pond = prepSprite("img/pond-02.png", 1, 1)

sprites.ui = {}
sprites.ui.bgmenu = prepSprite("img/bg-menu-dalle.png", 1, 1)


-- tileset2
tileset1 = {}
tileset1.tiles = love.graphics.newImage("img/tileset.png")

tileset1.image_width = tileset1.tiles:getWidth()
tileset1.image_height = tileset1.tiles:getHeight()
tileset1.tile_width = (tileset1.image_width / 20) - 2
tileset1.tile_height = (tileset1.image_height / 9) - 2
tileset1.quads = {}
for i=0,20 do
    for j=0,9 do
        --The only reason this code is split up in multiple lines
        --is so that it fits the page
        table.insert(tileset1.quads,
            love.graphics.newQuad(
                1 + j * (tileset1.tile_width + 2),
                1 + i * (tileset1.tile_height + 2),
                tileset1.tile_width, tileset1.tile_height,
                tileset1.image_width, tileset1.image_height))
    end
end

-- tileset2
tileset2 = {}
tileset2.tiles = love.graphics.newImage("img/tileset-earthy.png")

tileset2.image_width = tileset2.tiles:getWidth()
tileset2.image_height = tileset2.tiles:getHeight()
tileset2.image_ntilesWide = 8
tileset2.image_ntilesHigh = 6
tileset2.tile_width = (tileset2.image_width / tileset2.image_ntilesWide) - 2
tileset2.tile_height = (tileset2.image_height / tileset2.image_ntilesHigh) - 2
tileset2.quads = {}
for i=0,tileset2.image_ntilesWide do
    for j=0,tileset2.image_ntilesHigh do
        --The only reason this code is split up in multiple lines
        --is so that it fits the page
        table.insert(tileset2.quads,
            love.graphics.newQuad(
                1 + j * (tileset2.tile_width + 2),
                1 + i * (tileset2.tile_height + 2),
                tileset2.tile_width, tileset2.tile_height,
                tileset2.image_width, tileset2.image_height))
    end
end

