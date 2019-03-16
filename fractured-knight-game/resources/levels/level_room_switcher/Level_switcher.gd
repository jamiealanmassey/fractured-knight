#world complete.gd
extends Area2D

export(String) var room_name
 
var choosen_room
signal room_entered

func _on_SwitcherBlock_body_entered(body):
	print(room_name)
	choosen_room = room_name
	print(choosen_room)
	emit_signal("room_entered", choosen_room)
	get_tree().change_scene("res://resources/levels/Rooms/Procedural/current_room.tscn")

func get_room():
	return choosen_room