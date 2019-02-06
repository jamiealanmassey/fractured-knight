extends "res://addons/gut/test.gd"


func test_move_init():
	var move = load("res://resources/combat/combat-core/move.tscn").instance()
	var move_name = "Slash"
	var acc = 50
	var dmg = 6
	
	move.init(move_name, acc, dmg)
	assert_eq(move.move_name, "Slash", "Name should be Slash")
	assert_eq(move.get_accuracy(), 50, "Accuracy should be 50")
	assert_eq(move.get_damage(), 6, "Damage should be 6")
	


	