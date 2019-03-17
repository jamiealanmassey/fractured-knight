extends Node

signal finished_animation

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass




func _on_AnimatedSprite_finished_animation():
	emit_signal("finished_animation")
	pass # replace with function body
