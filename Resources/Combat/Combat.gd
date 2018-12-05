extends Node

# class member variables go here, for example:
var player_health = 100
var enemy_health = 25
var player_damage = 10
var enemy_damage = 4
var currently_in_combat = false

signal combat_ready
signal round_complete
signal enemy_died

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func prepare_combat():
	player_health = 100
	player_damage = 7
	enemy_health = 25
	enemy_damage = 4
	get_tree().get_root().find_node("UI", true, false).change_to_fighting()
	currently_in_combat = true
	emit_signal("combat_ready")

func player_attack():
	if (currently_in_combat):
		player_health = player_health - enemy_damage
		enemy_health = enemy_health - player_damage
		emit_signal("round_complete", player_health)
		handle_enemy_death()
	pass

func player_dodge():
	if (randi() > 60):
		player_health = player_health - enemy_damage 
	emit_signal("round_complete", player_health)
	pass

func player_block():
	player_health = player_health - enemy_damage/2
	emit_signal("round_complete", player_health)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_NPC_hit_player():
	print("signal sent and recieved")
	prepare_combat()
	currently_in_combat = true
	pass # replace with function body


func _on_UI_attack_chosen():
	if (currently_in_combat):
		player_attack()
	pass # replace with function body


func _on_UI_dodge_chosen():
	if (currently_in_combat):
		player_dodge()
	pass # replace with function body


func _on_UI_defend_chosen():
	if (currently_in_combat):
		player_block()
	pass # replace with function body
	
func handle_enemy_death():
	if (enemy_health <= 0):
		get_tree().get_root().find_node("UI", true, false).get_node("Panel").hide()
		emit_signal("enemy_died")
