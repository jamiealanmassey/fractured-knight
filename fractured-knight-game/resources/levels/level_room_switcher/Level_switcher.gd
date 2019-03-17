#world complete.gd
extends Area2D

export(String, FILE, "*.tscn") var worldScene
export (Vector2) var entry_position


func _on_SwitcherBlock_body_entered(body):
	if body.name == 'Player':
		print("next world");
		get_node('/root/game_manager').switch_scene(worldScene, entry_position)
	pass # replace with function body
