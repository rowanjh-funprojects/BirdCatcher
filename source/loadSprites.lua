sprites = {}

sprites.player = love.graphics.newImage("img/player_down walk.png")

sprites.birds = {}
sprites.birds.generic = love.graphics.newImage("img/bird2blue_0.10_fixed.png")
sprites.birds.special = love.graphics.newImage("img/parrot-60px.png")
sprites.birds.littleBrown = love.graphics.newImage("img/little-brown-bird-30px.png")

sprites.world = {}
sprites.world.treeGreenTiny = love.graphics.newImage("img/green-tree-tiny.png")
sprites.world.treeGreenSmall = love.graphics.newImage("img/green-tree-small.png")
sprites.world.treeGreenLarge = love.graphics.newImage("img/green-tree-large.png")
sprites.world.treeGreenLargeGlow = love.graphics.newImage("img/green-tree-large-glow.png")
sprites.world.treeGreenLarger = love.graphics.newImage("img/green-tree-larger.png")
sprites.world.treeGreenBiggest = love.graphics.newImage("img/green-tree-biggest.png")
sprites.world.treeStagSmall = love.graphics.newImage("img/stag-small.png")
sprites.world.treeStagLarge = love.graphics.newImage("img/stag-large.png")
sprites.world.treeYellowLarge = love.graphics.newImage("img/yellow-tree-large.png")
sprites.world.treeRedSmall = love.graphics.newImage("img/red-tree-small.png")
sprites.world.rockBare = love.graphics.newImage("img/rock-bare-1.png")
sprites.world.rockBareSmall = love.graphics.newImage("img/rock-bare-small-1.png")
sprites.world.rockBareLarge = love.graphics.newImage("img/rock-bare-large-1.png")
sprites.world.rockMossHuge = love.graphics.newImage("img/rock-moss-huge-1.png")
sprites.world.rockMoss = love.graphics.newImage("img/rock-moss-1.png")

sprites.ui = {}
sprites.ui.bgmenu = love.graphics.newImage("img/bg-menu-dalle.png")


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

