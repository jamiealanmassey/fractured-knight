extends "res://addons/gut/test.gd"


func test_move_init():
	var move = load("res://resources/combat/combat-core/move.gd").new()
	var move_name = "Slash"
	var acc = 50
	var dmg = 6
	
	move.init(move_name, acc, dmg)
	assert_eq(move.move_name, "Slash", "Name should be Slash")
	assert_eq(move.get_accuracy(), 50, "Accuracy should be 50")
	assert_eq(move.get_damage(), 6, "Damage should be 6")
	

# below test is deprecated

#func test_move_init_with_weapon():
#	var move = load("res://resources/combat/combat-core/move.gd").new()
#	var weapon = load("res://resources/combat/combat-core/weapon.gd").new()
#	var move_name = "Slash"
#	var acc = 50
#	var dmg = 6
#	weapon.init({"damage" : 3, "accuracy" : 10})
#
#	move.init(move_name, acc, dmg, weapon)
#	assert_eq(move.move_name, "Slash", "Name should be Slash")
#	assert_eq(move.get_accuracy(), 60, "Accuracy should be 60")
#	assert_eq(move.get_damage(), 9, "Damage should be 9")
#	assert_eq(move.weapon, weapon, "Weapon should still be referenced here")
#
	

	

	