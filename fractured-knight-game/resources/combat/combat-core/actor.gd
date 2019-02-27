extends Resource
export var stats = {'accuracy' : 0, 'damage' : 0}
export (Array) var moves 
export (int) var health
var armour


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func init(health):
	stats = {}
	moves = []
	self.health = health

func get_all_moves():
	return moves

func get_stat(stat_name):
	if (stats.has(stat_name.to_lower())):
		return stats[stat_name.to_lower()]
	else: 
		return 0
	
func set_stat(stat_name, value):
	stats[stat_name.to_lower()] = value
	
func add_move(move):
	moves.append(move)
	