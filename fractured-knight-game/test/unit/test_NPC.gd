extends "res://addons/gut/test.gd"

var actor

func before_all():
	pass

func before_each():
	pass

func test_loading_NPC():
	var test_npc = load("res://test/unit/NPC_example.tscn").instance()
	add_child(test_npc)
	var actor = test_npc.combat_actor
	assert_ne(actor, null, "Actor should not be null")
	var health = actor.health
	var moves = actor.get_all_moves()
	var accuracy = actor.get_stat('accuracy')
	var damage = actor.get_stat('damage')
	
	assert_eq(health, 50, "Health should be 50")
	assert_eq(accuracy, 10, "Accuracy should be 10")
	assert_eq(damage, 2, "Damage should be 2")
	
	assert_eq(moves[0].move_name, "punch", "Move name should be punch")
	
	
	pass