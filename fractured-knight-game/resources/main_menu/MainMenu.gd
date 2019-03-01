extends Control

signal game_start
signal game_load
signal game_option
signal game_help


## Signal is sent to start the game
func _on_BtnStart_pressed():
	## Start game
	emit_signal("game_start")
	print("play")
	pass 

##  Signal is sent to load a game version
func _on_BtnLoadGame_pressed():
	## Load game
	emit_signal("game_load")
	print("load game")
	pass

## opns the options window
func _on_BtnOptions_pressed():
	## opens the options window/pop-up
	emit_signal("game_option")
	print("options")
	pass

## Opens the help pop-up
func _on_BtnHelp_pressed():
	emit_signal("game_help")
	print("help")
	pass # replace with function body

##Opens the about us pop-up
func _on_BtnAbout_pressed():
	print("About")
	$AboutUs.show()
	pass # replace with function body

## closes the game.
func _on_BtnQuit_pressed():
	print("Quit")
	get_tree().quit()
	pass # replace with function body
