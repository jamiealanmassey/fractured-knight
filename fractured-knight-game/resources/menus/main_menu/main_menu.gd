extends Control

signal game_start
signal game_load
signal game_option
signal game_help

func _process(delta):
	if !$VBoxContainer.visible && Input.is_key_pressed(KEY_ESCAPE):
		$VBoxContainer.visible = true
		$SettingsMenu.visible = false
		$SettingsMenu.save_settings_menu()
	

func _ready():
	pass

## Signal is sent to start the game
func _on_BtnStart_pressed():
	var directory = Directory.new()
	if directory.file_exists('user://symbols.save'):
		directory.remove('user://symbols.save')
	
	emit_signal("game_start")
	get_node('/root/game_manager').switch_scene('res://resources/cut_scene/Intro/Fly_in_Space.tscn')
	

## opens the options window
func _on_BtnOptions_pressed():
	emit_signal("game_option")
	$VBoxContainer.visible = false
	$SettingsMenu.visible = true
	

## opens the help pop-up
func _on_BtnHelp_pressed():
	emit_signal("game_help")
	$Help.show()
	

## opens the about us pop-up
func _on_BtnAbout_pressed():
	$AboutUs.show()
	

## closes the game
func _on_BtnQuit_pressed():
	get_tree().quit()
	
