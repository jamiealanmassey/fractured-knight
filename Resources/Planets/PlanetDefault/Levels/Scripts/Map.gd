# Filename: Vikram Singh Kainth
# Breif:
# Author:
# Created: 

extends "res://Resources/Planets/PlanetDefaut/NPCs/AStar.gd"

## Calls function set_camera_limits to set a boundrary for the camera
func _ready():
	set_camera_limits()

##
func set_camera_limits():
	var map_limits = $Area.get_used_rect()
	var map_cellsize = $Area.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y