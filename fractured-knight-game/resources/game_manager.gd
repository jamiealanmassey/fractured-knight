extends Node

var current_scene = null
var current_camera = null
var player_combat_data = null
var screen_resolutions = []

const settings_file_name = 'user://settings.save'

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)
	screen_resolutions.append(Vector2(640, 400))
	screen_resolutions.append(Vector2(640, 480))
	screen_resolutions.append(Vector2(800, 600))
	screen_resolutions.append(Vector2(1024, 768))
	screen_resolutions.append(Vector2(1280, 720))
	screen_resolutions.append(Vector2(1280, 768))
	screen_resolutions.append(Vector2(1360, 768))
	screen_resolutions.append(Vector2(1366, 768))
	screen_resolutions.append(Vector2(1680, 1050))
	screen_resolutions.append(Vector2(1920, 1080))
	screen_resolutions.append(Vector2(2048, 1080))
	screen_resolutions.append(Vector2(2560, 1440))
	screen_resolutions.append(Vector2(3840, 2160))
	process_settings(load_settings())
	

func switch_scene(path):
	call_deferred('_deferred_switch_scene', path)

func _deferred_switch_scene(path):
	_save_dialogue_symbols()
	_cache_player_data()
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	current_scene.precache_player_combat_data = self.player_combat_data
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func _save_dialogue_symbols():
	var dialogue = get_node('/root/LevelManager/World/DialogueUI')
	if (dialogue != null):
		dialogue.save_symbols()
		print(dialogue.symbols)

func _cache_player_data():
	var player_node = get_node('/root/LevelManager/World/Player')
	if (player_node != null):
		self.player_combat_data = player_node.combat_data
	

func save_settings(settings):
	var settings_file = File.new()
	var settings_dir = Directory.new()
	if (settings_dir.file_exists(settings_file_name)):
		settings_dir.remove(settings_file_name)
	
	settings_file.open(settings_file_name, File.WRITE)
	settings_file.store_line(to_json(settings))
	settings_file.close()
	process_settings(settings)
	

func process_settings(settings):
	if settings == null:
		return
	
	# TODO set volume channels
	OS.window_fullscreen = settings['fullscreen']
	OS.vsync_enabled = settings['vsync']
	OS.window_size = screen_resolutions[settings['resolution']]
	

func load_settings():
	var settings = null
	var settings_file = File.new()
	if (settings_file.file_exists(settings_file_name)):
		settings_file.open(settings_file_name, File.READ)
		settings = parse_json(settings_file.get_line())
		settings_file.close()
		
	return settings
	

func find_resolution_index():
	var found_index = -1
	var windows_size = OS.window_size
	var matching_width = []
	for i in range(screen_resolutions.size()):
		if windows_size.x == screen_resolutions[i].x:
			matching_width.append(screen_resolutions[i])
	
	for i in range(matching_width.size()):
		found_index = screen_resolutions.find(matching_width[i])
		if windows_size.y == matching_width[i].y:
			break
		
	if found_index == -1:
		for i in range(screen_resolutions.size()):
			found_index = max(0, i - 1)
			if screen_resolutions[i].x > windows_size.x:
				break
		
	return found_index
	
