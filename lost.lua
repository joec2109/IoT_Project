-- Set the 'composer' library to a local variable named composer.
local composer = require( "composer" )
-- Create a new scene
local scene = composer.newScene()
-- function that takes the user back to the main menu, and resets the level to 1
local function gotoMainMenu()
    composer.removeScene("game")
    timer.cancelAll()
    composer.gotoScene("menu")
end

-- Function that creates the 'lost' scene.
function scene:create(event)
    local sceneGroup = self.view
    local background = display.newImageRect(sceneGroup, "background.png", 350, 350 * (display.pixelHeight / display.pixelWidth))
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local lostMenuBox = display.newRect(sceneGroup, display.contentCenterX, 225, 250, 100)
    lostMenuBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    lostMenuBox.strokeWidth = 4
    local newText = display.newText(sceneGroup, "You lost!", display.contentCenterX, 200, native.systemFont, 36)
    newText:setFillColor(255,0,0)
    local newText2 = display.newText(sceneGroup, "You made it to level " .. _G.level .. "!", display.contentCenterX, 250, native.systemFont, 24)
    newText2:setFillColor(255,0,0)

    local mainMenuBox = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, 150, 75)
    mainMenuBox.stroke= {type = "gradient", color1 = {0,0,0}, color2 = {0,0,0}, direction = "down"}
    mainMenuBox.strokeWidth = 4
    local mainMenuButton = display.newText(sceneGroup, "Main Menu", display.contentCenterX, display.contentCenterY, native.systemFont, 24)
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