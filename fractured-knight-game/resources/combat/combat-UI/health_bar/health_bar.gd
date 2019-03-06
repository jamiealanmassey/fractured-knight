extends Node2D

var max_health

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

# sets the inital maximum health for this health bar 
func set_max_health(max_health):
	self.max_health = max_health
	pass

# Called via signal when health needs to be updated
func update_health(health):
	$middle.scale = Vector2(1, health/max_health)
	pass
	
