extends Node

var current_scene = null
var current_camera = null
var player_combat_data = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)

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
	
