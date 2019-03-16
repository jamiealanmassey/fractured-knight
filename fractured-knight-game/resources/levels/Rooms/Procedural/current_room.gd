extends Node

var map = preload("res://resources/levels/Rooms/Procedural/mainRooms.tscn")
var level_name = preload("res://resources/levels/level_room_switcher/SwitcherBlock.tscn")

func _ready():
	next_world()

func next_world():
	var scene_id = global_room.get_room()
	var b = level_name.instance()
	print(scene_id)
	var file2Check = File.new()
	var doFileExists = file2Check.file_exists("res://resources/levels/Rooms/Temp_resource_saver/"+scene_id+".tscn")
	if(doFileExists):
		load_game_scene()
		print("next world exists");
	else:
		print("doesnt exist")