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

func init(health):
	weapons = []
	stats = {}
	base_moves = []
	self.health = health

func get_all_moves():
	var moves = []
	for weapon in weapons:
		for move in weapon.moves:
			moves.append(move)
	
	for move in base_moves:
		moves.append(move)
	return moves
		


func get_stat(stat_name):
	if (stats.has(stat_name.to_lower())):
		return stats[stat_name.to_lower()]
	else: 
		return 0
	
func set_stat(stat_name, value):
	stats[stat_name.to_lower()] = value
	
func add_move(move):
	base_moves.append(move)
	
func add_weapon(weapon):
	weapons.append(weapon)