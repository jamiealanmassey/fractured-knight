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
	
	
#adds a new move to this weapon
func add_move(move):
	moves.append(move)
	
