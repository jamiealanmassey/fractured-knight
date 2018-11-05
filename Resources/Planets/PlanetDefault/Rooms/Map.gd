extends Node
 

func _ready():
	set_camera_limits
	set_process_input(true)


func set_camera_limits():
	var map_limits = $Ground.get_used_rect()
	var map_cell_size = $Ground.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cell_size.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cell_size.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cell_size.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cell_size.y