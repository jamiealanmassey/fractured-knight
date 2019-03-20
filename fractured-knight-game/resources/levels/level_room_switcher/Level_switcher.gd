#world complete.gd
extends Area2D

export(String, FILE, "*.tscn") var tombScene
export(String, FILE, "*.tscn") var castleScene
export (Vector2) var entry_position

func _on_toDungeon_area_entered(area):
	var game_manager = get_node('/root/game_manager')
	if game_manager.defeat_percival:
		print("next world");
		get_node('/root/game_manager').switch_scene(tombScene, entry_position)

func _on_Lancelot_tree_exited():
	get_node('/root/game_manager').defeat_lancelot = true

func _on_Arthur_tree_exited():
	if get_node('/root/game_manager'):
		get_node('/root/game_manager').defeat_arthur = true

func _on_toCastleInside_area_entered(area):
	var game_manager = get_node('/root/game_manager')
	if game_manager.defeat_lancelot:
		print("next world");
		get_node('/root/game_manager').switch_scene(castleScene, entry_position)
	

func _on_Percival_tree_exited():
	if get_node('/root/game_manager'):
		get_node('/root/game_manager').defeat_percival = true
	

func _on_SwitcherBlock_area_entered(area):
	if get_node('/root/game_manager').defeat_arthur:
		get_tree().change_scene("res://resources/cut_scene/unit_round_table/Node2D.tscn")


func _on_SwitcherBlock_area_entered2(area):
	get_node('/root/game_manager').switch_scene("res://resources/levels/world_map/world_tilemap/master_world_plane.tscn", entry_position)
