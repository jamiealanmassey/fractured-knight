extends "res://addons/gut/test.gd"

var weapon_scene

func before_each():
	gut.p("ran setup", 2)

func after_each():
	gut.p("ran teardown", 2)

func before_all():
	weapon_scene = load("res://resources/combat/combat-core/weapon.tscn")
	


func test_get_attribute():
	var weapon = weapon_scene.instance()
	var attributes = {"damage" : 5, "accuracy" : 60}
	weapon.init(attributes)
	
	assert_eq(weapon.get_attribute("damage"), 5, "Damage should be set as 5")
	assert_eq(weapon.get_attribute("accuracy"), 60, "Accuracy should be set as 5")
	
func test_get_attribute_not_set():
	var weapon = weapon_scene.instance()
	var attributes = {"damage" : 5, "accuracy" : 60}
	weapon.init(attributes)
	
	assert_eq(weapon.get_attribute("crit"), 0, "Attributes not set should return 0")
	
	
func test_move_added():
	var weapon = weapon_scene.instance()
	weapon.init({"example" : 4})
	var move1 = load("res://resources/combat/combat-core/move.tscn").instance()
	move1.init("Slash", 60, 5, weapon)
	
	weapon.add_move(move1)
	
	assert_true(weapon.moves.has(move1), "Move just added should now be returned")
	
	
	var move2 = load("res://resources/combat/combat-core/move.tscn").instance()
	move2.init("Stab", 40, 8, weapon)
	
	weapon.add_move(move2)
	
	assert_true(weapon.moves.has(move2), "Another move just added, should be present")
	assert_true(weapon.moves.has(move1), "first move added should still be present")
	
	
	