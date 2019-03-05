extends Node

var current_scene = null
var current_camera = null
var current_player_data = null
var current_enemy_data = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)

func switch_scene(path):
	call_deferred('_deferred_switch_scene', path)

func _deferred_switch_scene(path):
	_save_dialogue_symbols()
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func _save_dialogue_symbols():
	var dialogue = get_node('/root/LevelManager/World/DialogueUI')
	if (dialogue != null):
		dialogue.save_symbols()
		print(dialogue.symbols)
