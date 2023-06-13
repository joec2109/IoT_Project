-- Set the 'composer' library to a local variable named composer.
local composer = require( "composer" )
-- Create a new scene
local scene = composer.newScene()

-- Takes user to the next level screen
local function gotoNextLevel()
    composer.removeScene("game")
    _G.level = _G.level + 1
    composer.gotoScene("game")
end

-- Creates the 'won' scene
function scene:create(event)
    local sceneGroup = self.view
    local background = display.newImageRect(sceneGroup, "background.png", 350, 350 * (display.pixelHeight / display.pixelWidth))
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local lostMenuBox = display.newRect(sceneGroup, display.contentCenterX, 200, 325, 100)
    lostMenuBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    lostMenuBox.strokeWidth = 4
    local newText = display.newText(sceneGroup, "Level " .. _G.level .. " completed!", display.contentCenterX, 175, native.systemFont, 36)
    newText:setFillColor(255,0,0)
    local newText2 = display.newText(sceneGroup, "You won!", display.contentCenterX, 225, native.systemFont, 36)
    newText2:setFillColor(255,0,0)

    local wonBox = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, 150, 75)
    wonBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    wonBox.strokeWidth = 4
    local wonButton = display.newText(sceneGroup, "Next Level", display.contentCenterX, display.contentCenterY, native.systemFont, 24)
    wonButton:setFillColor(0,0,0)

    wonBox:addEventListener( "tap", gotoNextLevel )
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