extends Node2D

func _ready():
	set_camera_position()

func set_camera_position():
	var map_limit = $Border.get_used_rect()
	var map_cell_size = $Border.cell_size
	$Entities/Player/Camera2D.limit_left = map_limit.position.x * map_cell_size.x
	$Entities/Player/Camera2D.limit_right = map_limit.end.x * map_cell_size.x
	$Entities/Player/Camera2D.limit_top = map_limit.position.y * map_cell_size.y
	$Entities/Player/Camera2D.limit_bottom = map_limit.end.y * map_cell_size.y
