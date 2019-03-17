#world complete.gd
extends Area2D

export(String, FILE, "*.tscn") var worldScene


func _on_SwitcherBlock_body_entered(body):
	if body.name == 'Player':
		print("next world");
		get_tree().change_scene(worldScene)
	pass # replace with function body
