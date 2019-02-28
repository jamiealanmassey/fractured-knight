extends Resource

export (Array) var moves
export var attributes_buffs = {'accuracy' : 0, 'damage' : 0}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func init(attributes):
	self.moves = []
	attributes_buffs = attributes

func get_attribute(attribute_name):
	if (attributes_buffs.has(attribute_name)):
		return attributes_buffs[attribute_name]
	else: 
		return 0
	

#adds a new move to this weapon
func add_move(move):
	moves.append(move)
	
