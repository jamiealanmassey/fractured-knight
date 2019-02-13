extends Node
var move_name
var accuracy
var damage
var weapon

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func init(move_name, accuracy, damage, weapon = null):
	self.move_name = move_name
	self.accuracy = accuracy
	self.damage = damage
	self.weapon = weapon

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_damage():
	if (weapon != null):
		return damage + weapon.get_attribute('damage')
	return damage
	
func get_accuracy():
	if weapon != null:
		return accuracy + weapon.get_attribute('accuracy')
	return accuracy


