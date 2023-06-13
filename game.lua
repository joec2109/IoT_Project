-- Set the 'composer' library to a local variable named composer.
local composer = require("composer")

-- Create a new scene
local scene = composer.newScene()

-- Creates a new group of tiles
local tileGroup = display.newGroup()

-- Declares variables for the creation of the maze
local blocks = {}
local canAddBlock = 0
local player = 0
local enemy1 = 0
enemies = {}
local coin = 0
local coinCache = {}
local currentPos = {}
local playerPos = {}
local starterPos = {}
local map = {}

-- Loop 40 times, creating a 40 by 40 maze blueprint (starts off with each tile having the value of 1)
for i = 0, 40, 1 do
    table.insert(map, {})
    for j = 0, 20, 1 do
        table.insert(map[i+1], 1)
    end
end

-- Declare more variables for the creation of the game menu
local stack = {}
local score = 0
local enemy = {}
local wonGame = false
local lostGame = false
local scoreText = ""
local livesText = ""
local gameLoopTimer
local drawingTilesTimer

-- Set the seed for the random number generator (helps generate different sequences of random numbers each time the program is run)
math.randomseed(os.time())

-- If called, go to level won screen
local function gotoLevelWon()
    wonGame = true

    if _G.level == 10 then
        composer.removeScene("completed")
        composer.gotoScene( "completed" )
        timer.cancel(gameLoopTimer)
    elseif _G.level < 10 then
        composer.removeScene("won")
        composer.gotoScene( "won" )
        timer.cancel(gameLoopTimer)
    end
end

-- If called, go to game lost screen
local function gameLost()
    lostGame = true
    composer.removeScene( "won" )
    composer.gotoScene( "lost" )

end

-- If user clicks on 'Up' button, move their character position 1 tile up
local function moveUp()
    if map[playerPos[1] - 1][playerPos[2]] == 0 or map[playerPos[1] - 1][playerPos[2]] == 3 or map[playerPos[1] - 1][playerPos[2]] == 4 then
        map[playerPos[1] - 1][playerPos[2]] = 2
        map[playerPos[1]][playerPos[2]] = 0
        playerPos = {playerPos[1]-1,playerPos[2]}
        player.y = player.y - 16
    end
end

-- If user clicks on 'Down' button, move their character position 1 tile down
local function moveDown()
    if map[playerPos[1] + 1][playerPos[2]] == 0 or map[playerPos[1] + 1][playerPos[2]] == 3 or map[playerPos[1] + 1][playerPos[2]] == 4 then
        map[playerPos[1] + 1][playerPos[2]] = 2
        map[playerPos[1]][playerPos[2]] = 0
        playerPos = {playerPos[1]+1,playerPos[2]}
        player.y = player.y + 16
    end
end

-- If user clicks on 'Left' button, move their character position 1 tile left
local function moveLeft()
    if map[playerPos[1]][playerPos[2] - 1] == 0 or map[playerPos[1]][playerPos[2] - 1] == 3 or map[playerPos[1]][playerPos[2] - 1] == 4 then
        map[playerPos[1]][playerPos[2] - 1] = 2
        map[playerPos[1]][playerPos[2]] = 0
        playerPos = {playerPos[1],playerPos[2] - 1}
        player.x = player.x - 16
    end
end

-- If user clicks on 'Right' button, move their character position 1 tile right
local function moveRight()
    if map[playerPos[1]][playerPos[2] + 1] == 0 or map[playerPos[1]][playerPos[2] + 1] == 3 or map[playerPos[1]][playerPos[2] + 1] == 4 then
        map[playerPos[1]][playerPos[2] + 1] = 2
        map[playerPos[1]][playerPos[2]] = 0
        playerPos = {playerPos[1],playerPos[2] + 1}
        player.x = player.x + 16
    end 
end

-- Function to generate the maze
local function generateMaze()
    -- Variable with coordinates within the Y axis that the maze can start at
    local startingOptions = {4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36}
    -- Then choose a random option from the 'startingOptions' list.
    local chosenOption = startingOptions[math.random(1, #startingOptions)]
    -- insert this option into the stack, as this is the first position to be used
    table.insert(stack, {chosenOption})
    -- Set the starting position to 2, as this will be where the player starts, and 2 represents the player in the maze array
    map[stack[1][1]][1] = 2
    playerPos = {stack[1][1], 1}
    starterPos = {stack[1][1], 1}

    -- Ensure the tile 1 space to the right of the starting position is also a free path.
    table.insert(stack, {stack[1][1], 2})
    map[stack[2][1]][stack[2][2]] = 0

    table.insert(currentPos, {stack[2][1], 2})

    -- Variable to insert possible path options
    options = {}

    -- Checking the options for a new tile to remove for the maze --

    for i=1, 4, 1 do
        -- Up/down movements
        if map[currentPos[1][1] + 2][currentPos[1][2]] == 1 and currentPos[1][1] + 2 ~= 18 then
            table.insert(options, {currentPos[1][1] + 2, currentPos[1][2], "Down"})
        end
        if map[currentPos[1][1] - 2][currentPos[1][2]] == 1 and currentPos[1][1] - 2 ~= 1 then
            table.insert(options, {currentPos[1][1] - 2, currentPos[1][2], "Up"})
        end

        -- Left/right movements
        if map[currentPos[1][1]][currentPos[1][2] + 2] == 1 and currentPos[1][2] + 2 ~= 18 then
            table.insert(options, {currentPos[1][1], currentPos[1][2] + 2, "Right"})
        end
        if map[currentPos[1][1]][currentPos[1][2] - 2] == 1 and currentPos[1][2] - 2 ~= 18 then
            table.insert(options, {currentPos[1][1], currentPos[1][2] - 2, "Left"})
        end
    end

    nextPos = {}

    -- As long as there is an option, loop through them and set the tiles to 0 --

    while #options > 0 do
        num = math.random(1, #options)

        nextPos[1] = {options[num][1], options[num][2], options[num][3]}

        if map[nextPos[1][1]][nextPos[1][2]] == 1 then
            map[nextPos[1][1]][nextPos[1][2]] = 0

            if nextPos[1][3] == "Down" then
                map [nextPos[1][1] - 1][nextPos[1][2]] = 0
            elseif nextPos[1][3] == "Up" then
                map[nextPos[1][1] + 1][nextPos[1][2]] = 0
            elseif nextPos[1][3] == "Right" then
                map[nextPos[1][1]][nextPos[1][2] - 1] = 0
            elseif nextPos[1][3] == "Left" then
                map[nextPos[1][1]][nextPos[1][2] + 1] = 0
            end
        end

        -- Once the option has been set to a path tile, remove it --
        table.remove(options, num)

        --[[ Check if the tiles around the latest position of the path generated are available options.
        If so, insert them in to the options array]]
        if nextPos[1][1] < 39 then
            if map[nextPos[1][1] + 2][nextPos[1][2]] == 1 and map[nextPos[1][1] + 1][nextPos[1][2]] == 1 then
                table.insert(options, {nextPos[1][1] + 2, nextPos[1][2], "Down"})
            end
        end
        if nextPos[1][1] > 3 then
            if map[nextPos[1][1] - 2][nextPos[1][2]] == 1 and map[nextPos[1][1] - 1][nextPos[1][2]] == 1 then
                table.insert(options, {nextPos[1][1] - 2, nextPos[1][2], "Up"})
            end
        end

        if nextPos[1][2] < 19 then
            if map[nextPos[1][1]][nextPos[1][2] + 2] == 1 and map[nextPos[1][1]][nextPos[1][2] + 1] == 1 then
                table.insert(options, {nextPos[1][1], nextPos[1][2] + 2, "Right"})
            end
        end
        if nextPos[1][2] > 3 then
            if map[nextPos[1][1]][nextPos[1][2] - 2] == 1 and map[nextPos[1][1]][nextPos[1][2] - 1] == 1 then
                table.insert(options, {nextPos[1][1], nextPos[1][2] - 2, "Left"})
            end
        end

        -- If there are any duplicated options, remove them from the array
        for i = 1, #options-1, 1 do
            for j = i + 1, #options, 1 do
                if options[i] == options[j] then
                    table.remove(options, j)
                end
            end
        end
    end

    -- Placing the monsters
    for i = 1, _G.level, 1 do
        table.insert(enemy, {1,1})
        while map[enemy[i][1]][enemy[i][2]] == 1 or map[enemy[i][1]][enemy[i][2]] == 2 do
            enemy[i][1] = math.random(1, #map)
            enemy[i][2] = math.random(1, 19)
            if map[enemy[i][1]][enemy[i][2]] == 0 then
                map[enemy[i][1]][enemy[i][2]] = 3
            end
        end
    end

    -- Placing coins

    local coins = {}

    for i=1, 20, 1 do
        local coinPos = {1,1}
        while #coins < 20 do
            coinPos = {math.random(1, #map), math.random(1, 19)}
            if map[coinPos[1]][coinPos[2]] == 0 then
                map[coinPos[1]][coinPos[2]] = 4
                table.insert(coins, {coinPos[1], coinPos[2]})
            end
        end
    end
end

-- Function to constantly move each enemy locally (to ensure each enemy moves on their own independently)
function moveEnemies()
    for i=1, #enemies, 1 do
        randNum = math.random(1,4)
        if randNum == 1 then
            if map[(enemies[i].y/16)][((enemies[i].x + 16) / 16)] == 0 or map[(enemies[i].y/16)][((enemies[i].x + 16) / 16)] == 4 or map[(enemies[i].y/16)][((enemies[i].x + 16) / 16)] == 3 or map[(enemies[i].y/16)][((enemies[i].x + 16) / 16)] == 2 then
                enemies[i]:translate(16, 0)
            end
        end
        if randNum == 2 then
            if map[(enemies[i].y/16)][((enemies[i].x - 16) /16)] == 0 or map[(enemies[i].y/16)][((enemies[i].x - 16) /16)] == 4 or map[(enemies[i].y/16)][((enemies[i].x - 16) /16)] == 3 or map[(enemies[i].y/16)][((enemies[i].x - 16) /16)] == 2 then
                enemies[i]:translate(-16, 0)
            end
        end
        if randNum == 3 then
            if map[((enemies[i].y+16)/16)][(enemies[i].x /16)] == 0 or map[((enemies[i].y+16)/16)][(enemies[i].x /16)] == 4 or map[((enemies[i].y+16)/16)][(enemies[i].x /16)] == 3 or map[((enemies[i].y+16)/16)][(enemies[i].x /16)] == 2 then
                enemies[i]:translate(0, 16)
            end
        end
        if randNum == 4 then
            if map[((enemies[i].y-16)/16)][(enemies[i].x /16)] == 0 or map[((enemies[i].y-16)/16)][(enemies[i].x /16)] == 4 or map[((enemies[i].y-16)/16)][(enemies[i].x /16)] == 3 or map[((enemies[i].y-16)/16)][(enemies[i].x /16)] == 2 then
                enemies[i]:translate(0, -16)
            end
        end
    end
end

-- Check if two rectangle shapes have collided
local function hasCollidedRect( obj1, obj2 )
 
    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end
 
    local left = obj1.contentBounds.xMin+1 <= obj2.contentBounds.xMin+1 and obj1.contentBounds.xMax-1 >= obj2.contentBounds.xMin+1
    local right = obj1.contentBounds.xMin+1 >= obj2.contentBounds.xMin+1 and obj1.contentBounds.xMin+1 <= obj2.contentBounds.xMax-1
    local up = obj1.contentBounds.yMin+1 <= obj2.contentBounds.yMin+1 and obj1.contentBounds.yMax-1 >= obj2.contentBounds.yMin+1
    local down = obj1.contentBounds.yMin+1 >= obj2.contentBounds.yMin+1 and obj1.contentBounds.yMin+1 <= obj2.contentBounds.yMax-1
 
    return ( left or right ) and ( up or down )
end

-- Handle collision events
local function collisionHandler()

    for i = 1,#enemies do
        -- Check for collision between player and this coin instance
        if ( enemies[i] and hasCollidedRect( player, enemies[i] ) ) then
            _G.lives = _G.lives - 1
            for i =1, #map do
                for j = 1, #map[i] do
                    if map[i][j] == 2 then
                        map[i][j] = 0
                    end
                end
            end
            map[starterPos[1]][1] = 2
            playerPos = {starterPos[1], 1}
            for y = 1, #map do
                for x=1, #map[y] do
                    -- The position of the player
                    if map[y][x] == 2 then
                        player.x = x * 16
                        player.y = y * 16
                    end
                end
            end
        end
    end

    for i = #coinCache, 1, -1 do
        -- Check for collision between player and this coin instance
        if ( coinCache[i] and hasCollidedRect( player, coinCache[i] ) ) then
            score = score + 1
            -- Remove the coin from the screen
            display.remove( coinCache[i] )
            -- Remove reference from table
            table.remove(coinCache, i)
            -- Handle other collision aspects like increasing score, etc.

            if score >= 10 then
                gotoLevelWon()
                timer.cancelAll()
            end
            
        end

    end

end

-- Game loop
local movementOptions = {}
local function gameLoop()

    collisionHandler()

    if _G.lives == 0 then
        gameLost()
        return true
    end

    if _G.lives > 0 then
        moveEnemies()

        scoreText:setFillColor(0,0,0)
        scoreText = display.newText(sceneGroup, "Score: " .. score, 50,16, native.systemFont, 18)
        scoreText:setFillColor(255,0,0)

        livesText:setFillColor(0,0,0)
        livesText = display.newText(sceneGroup, "Lives: " .. _G.lives, 310,16, native.systemFont, 18)
        livesText:setFillColor(255,0,0)

    end

end

-- Execute the game loop
gameLoopTimer = timer.performWithDelay( 125, gameLoop, 0 )

function scene:create(event)
    sceneGroup = self.view
    local phase = event.phase

    playerPos = {starterPos[1], 1}
    coins = {}
    coinCache = {}

    for i = #coinCache,1,-1 do
        table.remove(coinCache,i)
    end

    composer.removeScene("menu")

    for i = #enemies,1,-1 do
        table.remove(enemies,i)
    end


    local background = display.newRect(sceneGroup, display.contentCenterX,display.contentCenterY,display.pixelHeight, display.pixelWidth)
    background:setFillColor(255,255,255)

    -- Call the generateMaze function to create the maze
    generateMaze()

    -- Loop through each value in the map multidimensional array and draw the tiles
    for y = 1, #map do
        for x=1, #map[y] do

            -- Wall tiles
            if map[y][x] == 1 then

                local block = display.newRect(sceneGroup, x * 16, y * 16, 16, 16)
                block:setFillColor(0,0,0)

            end

            -- The position of the player
            if map[y][x] == 2 then

                player = display.newRect(sceneGroup, x * 16, y * 16, 16, 16)
                player:setFillColor(255,0,0)

            end

            -- The position of the enemy
            if map[y][x] == 3 then

                enemy1 = display.newRect(sceneGroup, x * 16, y * 16, 16, 16)
                table.insert(enemies, enemy1)
                enemy1:setFillColor(0,255,0)
                
            end

            -- The position of the coins
            if map[y][x] == 4 then

                
                coin = display.newRect(sceneGroup, x * 16, y * 16, 16, 16)
                table.insert(coinCache, coin)
                coin:setFillColor(255,255,0)
                

            end
        end
    end

    -- Create the buttons for player movement (up, down, left, right)
    local upButton = display.newRect(sceneGroup, display.contentCenterX, 695, 100, 50)
    upButton.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    upButton.strokeWidth = 4
    local upButtonText = display.newText(sceneGroup, "Up", display.contentCenterX, 695, native.systemFont, 18)
    upButtonText:setFillColor(0,0,0)

    local downButton = display.newRect(sceneGroup, display.contentCenterX, 750, 100, 50)
    downButton.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    downButton.strokeWidth = 4
    local downButtonText = display.newText(sceneGroup, "Down", display.contentCenterX, 750, native.systemFont, 18)
    downButtonText:setFillColor(0,0,0)

    local leftButton = display.newRect(sceneGroup, display.contentCenterX-110, 722.5, 110, 100)
    leftButton.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    leftButton.strokeWidth = 4
    local leftButtonText = display.newText(sceneGroup, "Left", display.contentCenterX-110, 722.5, native.systemFont, 18)
    leftButtonText:setFillColor(0,0,0)

    local rightButton = display.newRect(sceneGroup, display.contentCenterX+110, 722.5, 110, 100)
    rightButton.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    rightButton.strokeWidth = 4
    local rightButtonText = display.newText(sceneGroup, "Right", display.contentCenterX+110, 722.5, native.systemFont, 18)
    rightButtonText:setFillColor(0,0,0)

    -- Allow user to view their score and lives
    scoreText = display.newText(sceneGroup, "Score: " .. score, 50,16, native.systemFont, 18)
    scoreText:setFillColor(255,0,0)

    livesText = display.newText(sceneGroup, "Lives: " .. _G.lives, 310,16, native.systemFont, 18)
    livesText:setFillColor(255,0,0)

    upButton:addEventListener( "tap", moveUp )
    downButton:addEventListener( "tap", moveDown )
    leftButton:addEventListener("tap", moveLeft)
    rightButton:addEventListener("tap", moveRight)

end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then

    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        
    elseif (phase == "did") then

    end
end

function scene:destroy(event)
    local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene