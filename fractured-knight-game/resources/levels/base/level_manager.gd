extends Node

var current_combat = null
var combat_scene = load('res://resources/combat/combat-core/Combat.gd')

func _ready():
	var dialogue = get_node('/root/LevelManager/World/DialogueUI')
	if (dialogue != null):
		dialogue.load_symbols()
		print(dialogue.symbols)

func initiate_combat(enemy_data):
	current_combat = combat_scene.instantiate()
	current_combat.pause_mode = PAUSE_MODE_PROCESS ## force combat scene to carry on processing through pause
	current_combat.start_combat(get_node('World/Player').combat_actor, enemy_data)
	self.add_child(current_combat) ## must use current_combat.free_queue() once combat is over
	get_node('World').visible = false
	get_tree().paused = true
	
