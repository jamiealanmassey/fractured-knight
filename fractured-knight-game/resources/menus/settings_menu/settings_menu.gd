extends Control

func _ready():
	for resolution in get_node('/root/game_manager').screen_resolutions:
		$VBoxContainer/ResolutionOptions.add_item(str(resolution.x) + 'x' + str(resolution.y))
	
	self.load_settings_menu()
	

func save_settings_menu():
	var settings = {}
	settings['master_volume'] = $VBoxContainer/MasterVolumeSlider.value
	settings['fullscreen'] = $VBoxContainer/HBoxContainer/FullScreenCheck.pressed
	settings['vsync'] = $VBoxContainer/HBoxContainer2/VSyncCheck.pressed
	settings['resolution'] = $VBoxContainer/ResolutionOptions.selected
	get_node('/root/game_manager').save_settings(settings)
	

func load_settings_menu():
	var game_manager = get_node('/root/game_manager')
	var settings = game_manager.load_settings()
	if (settings != null):
		$VBoxContainer/MasterVolumeSlider.value = settings['master_volume']
		$VBoxContainer/HBoxContainer/FullScreenCheck.pressed = settings['fullscreen']
		$VBoxContainer/HBoxContainer2/VSyncCheck.pressed = settings['vsync']
		$VBoxContainer/ResolutionOptions.selected = settings['resolution']
	else:
		$VBoxContainer/MasterVolumeSlider.value = 100
		$VBoxContainer/AmbientVolumeSlider.value = 100
		$VBoxContainer/MusicVolumeSlider.value = 100
		$VBoxContainer/SfxVolumeSlider.value = 100
		$VBoxContainer/HBoxContainer/FullScreenCheck.pressed = OS.window_fullscreen
		$VBoxContainer/HBoxContainer2/VSyncCheck.pressed = OS.vsync_enabled
		$VBoxContainer/ResolutionOptions.selected = game_manager.find_resolution_index()
		
	
