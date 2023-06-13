-- Set the 'composer' library to a local variable named composer.
local composer = require( "composer" )
-- Create a new scene
local scene = composer.newScene()
-- function that takes the user back to the main menu, and resets the level to 1
local function gotoMainMenu()
    composer.removeScene("game")
    _G.level = 1
    composer.gotoScene("menu")
end

-- Create the 'howtoplay' scene with text values
function scene:create(event)
    local sceneGroup = self.view
    local background = display.newImageRect(sceneGroup, "background.png", 350, 350 * (display.pixelHeight / display.pixelWidth))
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local howtoplayTitleBox = display.newRect(sceneGroup, display.contentCenterX, 100, 325, 100)
    howtoplayTitleBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    howtoplayTitleBox.strokeWidth = 4
    local newText2 = display.newText(sceneGroup, "How To Play", display.contentCenterX, 100, native.systemFont, 36)
    newText2:setFillColor(255,0,0)

    local infoBox = display.newRect(sceneGroup, display.contentCenterX, 400, 325, 475)
    infoBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    infoBox.strokeWidth = 4

    local newText3 = display.newText(sceneGroup, "Use the up, down, right", display.contentCenterX, 200, native.systemFont, 24)
    newText3:setFillColor(255,0,0)
    local newText3 = display.newText(sceneGroup, "and left buttons on-screen", display.contentCenterX, 225, native.systemFont, 24)
    newText3:setFillColor(255,0,0)
    local newText3 = display.newText(sceneGroup, "to move", display.contentCenterX, 250, native.systemFont, 24)
    newText3:setFillColor(255,0,0)

    local newText4 = display.newText(sceneGroup, "Collect 10 of the coins to win!", display.contentCenterX, 300, native.systemFont, 24)
    newText4:setFillColor(255,0,0)

    local newText5 = display.newText(sceneGroup, "Avoid the green enemies!", display.contentCenterX, 350, native.systemFont, 24)
    newText5:setFillColor(255,0,0)

    local newText6 = display.newText(sceneGroup, "Complete all 10 levels!", display.contentCenterX, 400, native.systemFont, 24)
    newText6:setFillColor(255,0,0)

    local newText7 = display.newText(sceneGroup, "Each level increases with", display.contentCenterX, 450, native.systemFont, 24)
    newText7:setFillColor(255,0,0)
    local newText7 = display.newText(sceneGroup, "difficulty by increasing", display.contentCenterX, 475, native.systemFont, 24)
    newText7:setFillColor(255,0,0)
    local newText7 = display.newText(sceneGroup, "the number of enemies!", display.contentCenterX, 500, native.systemFont, 24)
    newText7:setFillColor(255,0,0)

    local newText8 = display.newText(sceneGroup, "Each maze is randomly", display.contentCenterX, 550, native.systemFont, 24)
    newText8:setFillColor(255,0,0)
    local newText8 = display.newText(sceneGroup, "generated.", display.contentCenterX, 575, native.systemFont, 24)
    newText8:setFillColor(255,0,0)

    local newText9 = display.newText(sceneGroup, "Enjoy!", display.contentCenterX, 615, native.systemFont, 24)
    newText9:setFillColor(255,0,0)

    local mainMenuBox = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY + 300, 150, 75)
    mainMenuBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    mainMenuBox.strokeWidth = 4
    local mainMenuButton = display.newText(sceneGroup, "Main Menu", display.contentCenterX, display.contentCenterY + 300, native.systemFont, 24)
    mainMenuButton:setFillColor(0,0,0)

    mainMenuBox:addEventListener( "tap", gotoMainMenu )
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