# Filename: PlayerMenu.gd
# Brief: Tracks and reacts to the user clicking the Player to show useful menus
# Author: Jamie Massey
# Created: 05/11/2018
extends Area2D

onready var shader = preload("res://Resources/Player/Shaders/PlayerHover.tres")
onready var sprite = get_node("../AnimatedSprite")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("clicked player -> open menu")
		$CanvasLayer/Menu.show()

func _on_Area2D_mouse_entered():
	sprite.set_material(shader)

func _on_Area2D_mouse_exited():
	sprite.set_material(null)

func _on_player_moved():
	$CanvasLayer/Menu.hide()
