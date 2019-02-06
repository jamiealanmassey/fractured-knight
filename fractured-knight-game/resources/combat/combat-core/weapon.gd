extends Node
var moves
var attributes_buffs

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func init(attributes):
	self.moves = []
	attributes_buffs = attributes

func get_attribute(attribute_name):
	var attribute_value = attributes_buffs.get(attribute_name, 0)
	return attribute_value
	
	
#constructs and adds a new move
func add_move(move_name, accuracy, damage):
	var new_move = load("res://resources/combat/combat-core/move.gd")
	new_move.init(move_name, accuracy, damage, self)
	moves.append(new_move)
	
