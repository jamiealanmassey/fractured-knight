extends "res://addons/gut/test.gd"

var combat
var move_scene
var weapon_scene

func before_all():
	combat = load("res://resources/combat/combat-core/Combat.tscn").instance()
	move_scene = load("res://resources/combat/combat-core/move.tscn")
	weapon_scene = load("res://resources/combat/combat-core/weapon.tscn")
	



func test_calculate_accuracy():
	var move = move_scene.instance()
	move.init("slash", 60, 8)
	
	assert_eq(combat.calculate_to_hit(move), 60, "Accuracy should be 60, slash accuracy")
	
	var sword = weapon_scene.instance()
	sword.init({"accuracy" : 20, "damage" : 5})
	
	var move2 = move_scene.instance()
	move2.init("stab", 50, 7, sword)
	
	assert_eq(combat.calculate_to_hit(move2), 70, "Accuracy should be 70, stab accuracy + sword accuracy")


func test_calculate_damage():
	var move = move_scene.instance()
	move.init("slash", 60, 8)
	
	assert_eq(combat.calculate_damage(move), 8, "Damage should be 8, slash damage")
	
	var sword = weapon_scene.instance()
	sword.init({"accuracy" : 20, "damage" : 5})
	
	var move2 = move_scene.instance()
	move2.init("stab", 50, 7, sword)
	
	assert_eq(combat.calculate_damage(move2), 12, "Damage should be 12, stab damage + sword damage")
	


	
	
	
	
	
	
	
	