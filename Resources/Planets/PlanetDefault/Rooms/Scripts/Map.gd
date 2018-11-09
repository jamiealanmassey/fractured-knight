# Filename: Map.gd
# Breif: Set the camera to follow the player 
# Author: Vikram Singh Kainth
# Created: 04/11/2018

extends Node

## Calls function set_camera_limits to set a boundrary for the camera
func _ready():
	set_camera_limits()

## Creates 2 variables
##  ==> map_limits: sets area to the used space in the map#
##  ==> map_cellsize: cell size of each tile
## Checks the player over the camera to see where the player is on 
## The screen and if theyare out of bounds
func set_camera_limits():
	var map_limits = $Area.get_used_rect()
	var map_cellsize = $Area.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y