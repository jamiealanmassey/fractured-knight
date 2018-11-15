extends Node

const SPEED = 0

export (int) var health
export (int) var detectRadius
export (int) var positionX
export (int) var positionY

var alive = true

export (int) var detect_radius

var target = null

func _ready():
	$DectRadius/CollisionShape2D.shape.radius = detect_radius

#func control(delta):
	#if parent is PathFollow2D:
	#	parent.set_offset(parent.get_offset() + Speed * delta)
	#	position = Vector2Q
		

#Once the player enters its dection radis (Defined by CollisionShape 2D under DecRadius) do this methon (Signal from player)
#Typically will announce some threat if hostile 
func on_detect_player():
	return $BaseClass.coverse()
