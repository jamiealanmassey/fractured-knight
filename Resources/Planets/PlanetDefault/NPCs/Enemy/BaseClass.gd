extends Node

const SPEED = 0

export (int) var health
export (int) var detectRadius

var alive = true

export (int) var detect_radius

var target = null

func _ready():
	$DetectRaduis/CollisionShape2D.shape.radius = detect_radius

func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + Speed * delta)
		position = Vector2Q
