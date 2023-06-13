-- Set the 'composer' library to a local variable named composer.
local composer = require( "composer" )

-- Hide the notification bar
display.setStatusBar( display.HiddenStatusBar )

-- Set the seed for the random number generator (helps generate different sequences of random numbers each time the program is run)
math.randomseed( os.time() )

-- Take the user to the 'menu' scene.
composer.gotoScene( "menu" )
