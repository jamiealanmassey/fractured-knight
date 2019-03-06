extends Resource
export (String) var move_name
export var attributes = {'accuracy' : 50, 'damage' : 5}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func init(move_name, accuracy, damage):
	self.move_name = move_name
	self.attributes.accuracy = accuracy
	self.attributes.damage = damage

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_damage():
	return attributes.damage
	
func get_accuracy():
	return attributes.accuracy


