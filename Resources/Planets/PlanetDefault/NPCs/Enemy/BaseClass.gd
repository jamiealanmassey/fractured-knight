extends Node

const SPEED = 0

export (int) var health

var alive = true

export (int) var detect_radius

var target = null

func _ready():
	$DectRadius/CollisionShape2D.shape.radius = detect_radius

