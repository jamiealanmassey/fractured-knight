extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# test code here 
	var player = load("res://resources/combat/combat-core/actor.gd").new()
	player.init(100)
	var enemy = load("res://resources/combat/combat-core/actor.gd").new()
	enemy.init(20)
	
	var move_scene = load("res://resources/combat/combat-core/move.gd")
	var weapon_scene = load("res://resources/combat/combat-core/weapon.gd")
	
	var move = move_scene.new()
	var move2 = move_scene.new()
	var sword = weapon_scene.new()
	
	move.init("punch", 60, 8)
	
	player.add_move(move)
	
	sword = weapon_scene.new()
	sword.init({"accuracy" : 20, "damage" : 5})
	
	move2 = move_scene.new()
	move2.init("stab", 50, 7, sword)
	
	sword.add_move(move2)
	
	player.add_weapon(sword)
	enemy.add_move(move)
	enemy.add_weapon(sword)
	
	player.set_stat("damage", 3)
	player.set_stat("accuracy", 10)
	
	enemy.set_stat("damage", 1)
	enemy.set_stat("accuracy", 5)
	
	var combat = load("res://resources/combat/combat-core/Combat.tscn").instance()
	add_child(combat)
	#starts combat with given seed
	combat.start_combat(player, enemy, 800.5)
	print(combat.player.health)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
