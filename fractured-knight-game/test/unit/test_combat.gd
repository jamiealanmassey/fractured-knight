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
	enemy.init(20)
	
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
	
	var combat_finished_signal_emitted = false
	var move_choice = 0
	

	var expected_signal_count = {'combat_finished' : 0, 'show_fighting_options' : 0, 'show_menu_options' : 0, 'output_only' : 0, 'display_text' : 0}
	watch_signals(combat)
	var round_count = 0
	
	while !combat_finished_signal_emitted:
		#Go into fight mode
		combat.on_button_pressed(0) 
		expected_signal_count.show_fighting_options += 1
		#number of times fighting options moveed into should be 1 more than before
		assert_signal_emit_count(combat, "show_fighting_options", expected_signal_count.show_fighting_options)
		
		#record previous round's health for future checks
		var player_health = combat.player.health
		var enemy_health = combat.enemy.health
		
		#choose an attack
		combat.on_button_pressed(move_choice) 
		#Shoud emit output signal excatly once
		expected_signal_count.output_only += 1
		
		#checkes player attack message
		if player_health != combat.player.health:
			assert_signal_emitted_with_parameters(combat, "display_text", ["You hit the enemy for " + str(enemy_health - combat.enemy.health)], expected_signal_count.display_text)
		else:
			assert_signal_emitted_with_parameters(combat, "display_text", ["You missed"], expected_signal_count.display_text)
		expected_signal_count.display_text += 1
		
		#checkes for enemy death message
		if combat.enemy.health <= 0:
			assert_signal_emitted_with_parameters(combat, "display_text", ["Enemy defeated"], expected_signal_count.display_text)
			assert_signal_emitted_with_parameters(combat, "combat_finished", [player, enemy, "Player won"])
			expected_signal_count.display_text += 1
			combat_finished_signal_emitted = true
		
		#checkes enemy attack message
		if enemy_health != combat.enemy.health:
			assert_signal_emitted_with_parameters(combat, "display_text", ["Player got hit for " + str(player_health - combat.player.health)], expected_signal_count.display_text)
			expected_signal_count.display_text += 1
		elif combat.enemy_health != 0:
			assert_signal_emitted_with_parameters(combat, "display_text", ["Enemy missed"], expected_signal_count.display_text)
			expected_signal_count.display_text += 1
		
		
		#checks for player death message
		if combat.player.health <= 0:
			assert_signal_emitted_with_parameters(combat, "display_text", ["Player defeated"], expected_signal_count.display_text)
			assert_signal_emitted_with_parameters(combat, "combat_finished", [player, enemy, "Enemy won"])
			expected_signal_count.display_text += 1
			combat_finished_signal_emitted = true
		
		expected_signal_count.show_menu_options += 1
		
		assert_signal_emit_count(combat, "show_menu_options", expected_signal_count.show_menu_options)
		assert_signal_emit_count(combat, "display_text", expected_signal_count.display_text)
		move_choice = (move_choice + 1) % 2
		
	assert_signal_emit_count(combat, "combat_finished", 1, "Combat finished signal should only fire exactly once")

func _test_ui_buttons():
	var combat_new = load("res://resources/combat/combat-core/Combat.tscn").instance()
	
	while true:
		combat_new.start_combat(player, enemy)
		pass
	
	
	