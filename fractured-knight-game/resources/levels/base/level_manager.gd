extends Node

var current_combat = null
var pause_menu = null

var scene_id

func _ready():
	var dialogue = get_node('World/DialogueUI')
	var player = get_node('World/Entities/Player')
	pause_menu = get_node('PauseMenu')
	
	if (dialogue != null):
		dialogue.load_symbols()
	

func _process(delta):
	if (pause_menu != null && !pause_menu.active && pause_menu.is_ready() && Input.is_action_pressed('ui_cancel')):
		pause_menu.visible = true
		pause_menu.active = true
		pause_menu.pause_mode = Node.PAUSE_MODE_PROCESS
		pause_menu.kickstart()
		get_tree().paused = true
	

func start_dialogue(name):
	get_node('World/DialogueUI').start_dialogue(name)
	get_node('World/Entities/Player').lock_movement = true
	


func set_player_position(position):
	$World/Entities/Player.position = position

func is_dialogue_playing():
	var dialogue = get_node('World/DialogueUI')
	if (dialogue != null && dialogue.processing):
		return true
		
	return false
	


func initiate_combat(enemy):
	var combat_scene = load('res://resources/combat/combat_core/combat.tscn')
	var camera_pos = get_node('/root/game_manager').current_camera.get_camera_position()
	var view_size = get_viewport().size
	current_combat = combat_scene.instance()
	current_combat.pause_mode = PAUSE_MODE_PROCESS ## force combat scene to carry on processing through pause
	current_combat.start_combat(get_node('World/Entities/Player'), enemy)
	current_combat.connect('combat_finished', self, '_on_combat_finished')
	current_combat.rect_position = Vector2(camera_pos.x - (view_size.x / 2), camera_pos.y - (view_size.y / 2))
	self.add_child(current_combat) ## must use current_combat.free_queue() once combat is over
	get_node('World').visible = false
	get_tree().paused = true
	

func _on_combat_finished(player, enemy, message):
	print(message)
	if (message == 'Player won'):
		enemy.queue_free()
		print('enemy dead and destroyed')
		
	current_combat.queue_free()
	current_combat = null
	get_node('World').visible = true
	get_tree().paused = false
	

func _on_PauseMenu_resume_game():
	pause_menu.pause_mode = Node.PAUSE_MODE_INHERIT
	pause_menu.active = false
	pause_menu.visible = false
	get_tree().paused = false
	

func _on_DialogueUI_on_context_finish():
	get_node('World/Entities/Player').lock_movement = false

## Vikrams Stuff 
## TODO commenting 
#func _on_SwitcherBlock_body_entered(body):
#	scene_id = $World/SwitcherBlock.room_name
#	print(scene_id)
#	var file2Check = File.new()
#	var doFileExists = file2Check.file_exists("res://resources/levels/Rooms/Temp_resource_saver/" + str(scene_id) + ".tscn")
#	if(doFileExists):
#		print("next world exists");
#		get_tree().change_scene("res://resources/levels/Rooms/Temp_resource_saver/" + str(scene_id) + ".tscn")
#	else:
#		print("doesnt exist")
#		get_tree().change_scene("res://resources/levels/Rooms/Procedural/mainRooms.tscn")
