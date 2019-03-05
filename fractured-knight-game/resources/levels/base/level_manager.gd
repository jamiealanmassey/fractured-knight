extends Node

var current_combat = null
var current_enemy = null
var precache_player_combat_data = null

func _ready():
	var dialogue = get_node('World/DialogueUI')
	var player = get_node('World/Player')
	if (player != null && precache_player_combat_data != null):
		player.combat_actor = precache_player_combat_data
	
	if (dialogue != null):
		dialogue.load_symbols()

func initiate_combat(enemy):
	var combat_scene = load('res://resources/combat/combat-core/Combat.tscn')
	var camera_pos = get_node('/root/game_manager').current_camera.get_camera_position()
	var view_size = get_viewport().size
	current_enemy = enemy
	current_combat = combat_scene.instance()
	current_combat.pause_mode = PAUSE_MODE_PROCESS ## force combat scene to carry on processing through pause
	current_combat.start_combat(get_node('World/Player').combat_actor, current_enemy.combat_actor)
	current_combat.connect('combat_finished', self, '_on_combat_finished')
	current_combat.rect_position = Vector2(camera_pos.x - (view_size.x / 2), camera_pos.y - (view_size.y / 2))
	self.add_child(current_combat) ## must use current_combat.free_queue() once combat is over
	get_node('World').visible = false
	get_tree().paused = true
	

func _on_combat_finished(player, enemy, message):
	print(message)
	if (message == 'Player won'):
		current_enemy.queue_free()
		print('enemy dead and destroyed')
		
	current_combat.queue_free()
	current_combat = null
	current_enemy = null
	get_node('World').visible = true
	get_tree().paused = false
	
