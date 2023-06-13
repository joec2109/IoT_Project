-- Set the 'composer' library to a local variable named composer.
local composer = require("composer")

-- Create a new scene
local scene = composer.newScene()

-- Function that takes the user to the 'game' scene once they have clicked on play.
local function gotoGame()
    _G.level = 1
    composer.gotoScene( "game" , { time=1000, effect="crossFade" } )
    scene:removeEventListener("create", scene)
    scene:removeEventListener("show", scene)
    scene:removeEventListener("hide", scene)
    scene:removeEventListener("destroy", scene)
end

-- Function that takes the user to the 'howtoplay' scene once they have clicked on the how to play button.
local function gotoHowToPlay()
    composer.removeScene("howtoplay")
    composer.gotoScene( "howtoplay" , { time=1000, effect="crossFade" } )
    scene:removeEventListener("create", scene)
    scene:removeEventListener("show", scene)
    scene:removeEventListener("hide", scene)
    scene:removeEventListener("destroy", scene)
end

-- Function that sets the mode of the game to easy
local function easyMode()
    _G.lives = 5
    _G.mode = "Easy"
end

-- Function that sets the mode of the game to normal
local function normalMode()
    _G.lives = 3
    _G.mode = "Normal"
end

-- Function that sets the mode of the game to hard
local function hardMode()
    _G.lives = 1
    _G.mode = "Hard"
end

-- Create the main menu scene.
function scene:create(event)
    sceneGroup = self.view

    -- Create background
    local background = display.newImageRect(sceneGroup, "background.png", 350, 350 * (display.pixelHeight / display.pixelWidth))
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Create game title
    local titleBox = display.newRect(sceneGroup, display.contentCenterX, 100, 250, 100)
    titleBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    titleBox.strokeWidth = 4
    local title = display.newImageRect(sceneGroup, "title.png", 200,50)
    title.x = display.contentCenterX
    title.y = 100

    -- Create play button
    local playButtonBox = display.newRect(sceneGroup, display.contentCenterX, 300, 150, 75)
    playButtonBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    playButtonBox.strokeWidth = 4
    local playButton = display.newText(sceneGroup, "Play", display.contentCenterX, 300, native.systemFont, 36)
    playButton:setFillColor(0,0,0)

    -- Create how to play button
    local howToPlayButtonBox = display.newRect(sceneGroup, display.contentCenterX, 450, 225, 75)
    howToPlayButtonBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    howToPlayButtonBox.strokeWidth = 4
    local howToPlayButton = display.newText(sceneGroup, "How To Play", display.contentCenterX, 450, native.systemFont, 36)
    howToPlayButton:setFillColor(0,0,0)

    -- Create exit button
    local exitButtonBox = display.newRect(sceneGroup, display.contentCenterX, 600, 150, 75)
    exitButtonBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    exitButtonBox.strokeWidth = 4
    local exitButton = display.newText(sceneGroup, "Exit", display.contentCenterX, 600, native.systemFont, 36)
    exitButton:setFillColor(0,0,0)

    -- Create easy mode button
    local easyButtonBox = display.newRect(sceneGroup, 50, 750, 100, 50)
    easyButtonBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    easyButtonBox.strokeWidth = 4
    local easyButton = display.newText(sceneGroup, "Easy", 50, 750, native.systemFont, 16)
    easyButton:setFillColor(0,0,0)

    -- Create normal mode button
    local normalButtonBox = display.newRect(sceneGroup, display.contentCenterX, 750, 100, 50)
    normalButtonBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    normalButtonBox.strokeWidth = 4
    local normalButton = display.newText(sceneGroup, "Normal", display.contentCenterX, 750, native.systemFont, 16)
    normalButton:setFillColor(0,0,0)

    -- Create hard mode button
    local hardButtonBox = display.newRect(sceneGroup, display.contentCenterX + 125, 750, 100, 50)
    hardButtonBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    hardButtonBox.strokeWidth = 4
    local hardButton = display.newText(sceneGroup, "Hard", display.contentCenterX + 125, 750, native.systemFont, 16)
    hardButton:setFillColor(0,0,0)

    -- Add event listeners to the buttons to detect if they have been pressed
    playButtonBox:addEventListener( "tap", gotoGame )
    howToPlayButtonBox:addEventListener( "tap", gotoHowToPlay )
    exitButtonBox:addEventListener("tap", native.requestExit)

    easyButtonBox:addEventListener("tap", easyMode)
    normalButtonBox:addEventListener("tap", normalMode)
    hardButtonBox:addEventListener("tap", hardMode)
end

-- Once the menu scene is shown, this function is called.
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    normalMode()

    if (phase == "will") then

    elseif (phase == "did") then

    end
end

-- Once the menu scene is hidden, this function is called.
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        
    elseif (phase == "did") then

    end
end

-- This function is called once the menu scene is destroyed.
function scene:destroy(event)
    local sceneGroup = self.view
end

-- Event listeners are added to the 'create','show','hide' and 'destroy' functions
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

-- Return the menu scene
return scene