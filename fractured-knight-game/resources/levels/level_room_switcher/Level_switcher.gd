#world complete.gd
extends Area2D

export(String) var room_name
 
var choosen_room
signal room_name_val(Room_name)

func _on_SwitcherBlock_body_entered(body):
	print(room_name)
	choosen_room = room_name
	print(choosen_room)
	emit_signal(room_name_val, room_name)
	get_tree().change_scene("res://resources/levels/Rooms/Procedural/current_room.tscn")

func get_room():
	return choosen_room