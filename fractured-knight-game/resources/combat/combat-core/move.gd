extends Node
var name
var damage
var accuracy
var weapon

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func init(name, damage, accuracy, weapon):
	self.name = name
	self.damage = damage
	self.accuracy = accuracy
	self.weapon = weapon

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_damage():
	return damage
	
func get_accuracy():
	return accuracy


