#world complete.gd
extends Area2D

export(String, FILE, "*.tscn") var tombScene
export(String, FILE, "*.tscn") var castleScene
export (Vector2) var entry_position

func _on_toDungeon_area_entered(area):
	var game_manager = get_node('/root/game_manager')
	if game_manager.defeated.has('lancelot'):
		get_node('/root/game_manager').switch_scene(tombScene, entry_position)

func _on_Arthur_tree_exited():
	if get_node('/root/game_manager'):
		get_node('/root/game_manager').defeated.append('arthur')

func _on_toCastleInside_area_entered(area):
	var game_manager = get_node('/root/game_manager')
	var percival = game_manager.defeated.has('percival')
	var galahad = game_manager.defeated.has('galahad')
	var bedivere = game_manager.defeated.has('bedivere')
	var lancelot = game_manager.defeated.has('lancelot')
	if percival && galahad && bedivere && lancelot:
		get_node('/root/game_manager').switch_scene(castleScene, entry_position)
	

func _on_Percival_tree_exited():
	if get_node('/root/game_manager'):
		get_node('/root/game_manager').defeated.append('percival')
	

func _on_SwitcherBlock_area_entered(area):
	if get_node('/root/game_manager').defeated.has('arthur'):
		get_tree().change_scene('res://resources/cut_scene/unit_round_table/Node2D.tscn')
	

func _on_SwitcherBlock_area_entered2(area):
	get_node('/root/game_manager').switch_scene('res://resources/levels/world_map/world_tilemap/master_world_plane.tscn', entry_position)
	

func _on_Lancelot_tree_exited():
	if get_node('/root/game_manager'):
		get_node('/root/game_manager').defeated.append('lancelot')

func _on_Galahad_tree_exited():
	if get_node('/root/game_manager'):
		get_node('/root/game_manager').defeated.append('galahad')

func _on_Bedivere_tree_exited():
	if get_node('/root/game_manager'):
		get_node('/root/game_manager').defeated.append('bedivere')
