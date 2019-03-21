extends Control

signal apply_pressed

func _ready():	
	self.load_settings_menu()
	

func save_settings_menu():
	var settings = {}
	settings['master_volume'] = $VBoxContainer/MasterVolumeSlider.value
	settings['fullscreen'] = $VBoxContainer/HBoxContainer/FullScreenCheck.pressed
	settings['vsync'] = $VBoxContainer/HBoxContainer2/VSyncCheck.pressed
	get_node('/root/game_manager').save_settings(settings)
	

func load_settings_menu():
	var game_manager = get_node('/root/game_manager')
	var settings = game_manager.load_settings()
	if (settings != null):
		$VBoxContainer/MasterVolumeSlider.value = settings['master_volume']
		$VBoxContainer/HBoxContainer/FullScreenCheck.pressed = settings['fullscreen']
		$VBoxContainer/HBoxContainer2/VSyncCheck.pressed = settings['vsync']
	else:
		$VBoxContainer/MasterVolumeSlider.value = 100
		$VBoxContainer/HBoxContainer/FullScreenCheck.pressed = OS.window_fullscreen
		$VBoxContainer/HBoxContainer2/VSyncCheck.pressed = OS.vsync_enabled
		
	

func _on_ApplyButton_pressed():
	save_settings_menu()
	emit_signal('apply_pressed')
