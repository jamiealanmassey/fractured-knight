extends Node
var weapons
var stats
var base_moves
var health
var armour


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func get_all_moves():
	var moves = []
	for weapon in weapons:
		moves.append(weapon.moves)
	moves.append(base_moves)
	return moves
		

func _init(health):
	weapons = []
	stats = {}
	base_moves = []
	self.health = health
	
func get_stat(stat_name):
	var stat_value = stats.get(stat_name, 0)
	return stat_value