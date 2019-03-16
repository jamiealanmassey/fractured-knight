#world complete.gd
extends Area2D



func _on_SwitcherBlock_body_entered(body):
	print("next world");
	get_tree().change_scene("res://resources/levels/Rooms/Procedural/current_room.tscn")
