extends "res://addons/gut/test.gd"

var combat
var move_scene
var weapon_scene
var player
var enemy
var move
var sword
var move2


func before_each():
	combat = load("res://resources/combat/combat-core/Combat.tscn").instance()
	player = load("res://resources/combat/combat-core/actor.tscn").instance()
	player.init(50)
	enemy = load("res://resources/combat/combat-core/actor.tscn").instance()
	enemy.init(10)
	
	move_scene = load("res://resources/combat/combat-core/move.tscn")
	weapon_scene = load("res://resources/combat/combat-core/weapon.tscn")
	
	move = move_scene.instance()
	move2 = move_scene.instance()
	sword = weapon_scene.instance()
	
	move.init("punch", 60, 8)
	
	player.add_move(move)
	
	sword = weapon_scene.instance()
	sword.init({"accuracy" : 20, "damage" : 5})
	
	move2 = move_scene.instance()
	move2.init("stab", 50, 7, sword)
	
	sword.add_move(move2)
	
	player.add_weapon(sword)
	enemy.add_move(move)
	enemy.add_weapon(sword)
	
	player.set_stat("damage", 3)
	player.set_stat("accuracy", 10)
	
	enemy.set_stat("damage", 1)
	enemy.set_stat("accuracy", 5)
	
	#starts combat with given seed
	combat.start_combat(player, enemy, 800.5)
	move_scene = load("res://resources/combat/combat-core/move.tscn")
	weapon_scene = load("res://resources/combat/combat-core/weapon.tscn")
	



func test_calculate_accuracy():
	assert_eq(combat.calculate_to_hit(move), 60, "Accuracy should be 60, slash accuracy")
	assert_eq(combat.calculate_to_hit(move2), 70, "Accuracy should be 70, stab accuracy + sword accuracy")


func test_calculate_damage():
	assert_eq(combat.calculate_damage(move), 8, "Damage should be 8, slash damage")
	assert_eq(combat.calculate_damage(move2), 12, "Damage should be 12, stab damage + sword damage")
	

func test_change_to_combat():
	watch_signals(combat)
	
	assert_eq(combat.state, 0, "Combat state should initialise to 0")
	
	combat.on_button_pressed(0)
	
	
	assert_signal_emitted(combat, "show_fighting_options", "Show_combat_options should have been emitted")
	assert_signal_emitted_with_parameters(combat, "show_fighting_options", [player.get_all_moves()], 0) 
	assert_eq(combat.state, 1, "Combat state should now be 1")
	
func test_resolve_attack_signals():
	combat.on_button_pressed(0) 
	watch_signals(combat)
	combat.on_button_pressed(0) 
	
	assert_signal_emitted(combat, "output_only", "output_only should have been emitted")
	assert_signal_emit_count(combat, "display_text", 2)
	assert_signal_emitted(combat, "show_menu_options", "Starting menu options should be signaled for")
	assert_eq(combat.state, 0, "state should now be 0 again")
	
func test_attacks():
	#first attack
	combat.on_button_pressed(0) 
	combat.on_button_pressed(0) 
	
	#second attack
	combat.on_button_pressed(0) 
	combat.on_button_pressed(1) 
	
	#third attack
	combat.on_button_pressed(0) 
	combat.on_button_pressed(1) 
	
	#fourth attack
	combat.on_button_pressed(0) 
	combat.on_button_pressed(1) 
	
	#fifth attack
	combat.on_button_pressed(0) 
	combat.on_button_pressed(0) 
	
	
	
	
	
	
	
	
	
	