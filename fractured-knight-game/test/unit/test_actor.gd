extends "res://addons/gut/test.gd"

var actor

func before_all():
	gut.p("ran run setup", 2)

func before_each():
	actor = load("res://resources/combat/combat-core/actor.gd").new()

func test_health():
	actor.init(50)
	
	assert_eq(actor.health, 50, "Health should have initialised to 50")
	
func test_get_base_moves():
	actor.init(50)
	
	var punch = load("res://resources/combat/combat-core/move.gd").new()
	punch.init("punch", 50, 6)
	actor.add_move(punch)
	
	assert_true(actor.get_all_moves().has(punch), "Actor should have the punch move")
	
	var kick =  load("res://resources/combat/combat-core/move.gd").new()
	kick.init("kick", 80, 4)
	
	actor.add_move(kick)
	
	print(actor.get_all_moves())
	assert_true(actor.get_all_moves().has(punch), "Actor should still have the punch move")
	assert_true(actor.get_all_moves().has(kick), "Actor should have the kick move")
	
func test_get_weapon_moves():
	actor.init(50)
	
	var move_scene = load("res://resources/combat/combat-core/move.gd")
	var sword = load("res://resources/combat/combat-core/weapon.gd").new()
	sword.init({"damage" : 5})
	
	var slash = move_scene.new()
	slash.init("Slash", 60, 8, sword)
	var stab =  move_scene.new()
	stab.init("Stab", 80, 6, sword)
	sword.add_move(slash)
	sword.add_move(stab)
	
	var hammer = load("res://resources/combat/combat-core/weapon.gd").new()
	hammer.init({"damage" : 5})
	
	var smash = move_scene.new()
	smash.init("Smash", 60, 8, hammer)
	hammer.add_move(smash)
	
	actor.add_weapon(sword)
	actor.add_weapon(hammer)
	
	var result_moves = actor.get_all_moves()
	
	assert_true(result_moves.has(slash), "Resulting moves should have slash")
	assert_true(result_moves.has(stab), "Resulting moves should have stab")
	assert_true(result_moves.has(smash), "Resulting moves should have smash")
	
	
func test_get_base_and_weapon_moves():
	actor.init(50)
	
	var punch = load("res://resources/combat/combat-core/move.gd").new()
	punch.init("punch", 50, 6)
	actor.add_move(punch)
	
	var kick =  load("res://resources/combat/combat-core/move.gd").new()
	kick.init("kick", 80, 4)
	
	actor.add_move(kick)
	
	var move_scene = load("res://resources/combat/combat-core/move.gd")
	var sword = load("res://resources/combat/combat-core/weapon.gd").new()
	sword.init({"damage" : 5})
	
	var slash = move_scene.new()
	slash.init("Slash", 60, 8, sword)
	var stab =  move_scene.new()
	stab.init("Stab", 80, 6, sword)
	sword.add_move(slash)
	sword.add_move(stab)
	
	var hammer = load("res://resources/combat/combat-core/weapon.gd").new()
	hammer.init({"damage" : 5})
	
	var smash = move_scene.new()
	smash.init("Smash", 60, 8, hammer)
	hammer.add_move(smash)
	
	actor.add_weapon(sword)
	actor.add_weapon(hammer)
	
	var result_moves = actor.get_all_moves()
	
	assert_true(result_moves.has(slash), "Resulting moves should have slash")
	assert_true(result_moves.has(stab), "Resulting moves should have stab")
	assert_true(result_moves.has(smash), "Resulting moves should have smash")
	assert_true(actor.get_all_moves().has(punch), "Resulting moves should have punch")
	assert_true(actor.get_all_moves().has(kick), "Resulting moves should have kick")
	
	
func test_get_stat():
	actor.init(50)
	actor.set_stat("damage", 5)
	actor.set_stat("accuracy", 6)
	
	assert_eq(actor.get_stat("damage"), 5, "Damage should be 5")
	assert_eq(actor.get_stat("accuracy"), 6, "Accuracy should be 6")
	
	
func test_get_stat_not_set():
	actor.init(50)
	
	assert_eq(actor.get_stat("crit"), 0, "Stats not set should return 0")
	
	
	
	
	
	
	
	
	
	