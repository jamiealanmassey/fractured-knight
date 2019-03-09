extends Node2D

## pre-load room script to accesss that scene and methord
var Room = preload("res://resources/levels/Rooms/Procedural/room.tscn")

## Constants for tile_size (32 x 32)
const TILE_SIZE = 32

## varibles for number of rooms and bound for sizes
var num_rooms = 10
var room_min_size = 4
var room_max_size = 10

## Initilise the rand func 
## calls makes areas
func _ready():
	randomize()
	makes_areas()

## Makes rooms using a for loop to cycle through the amount of rooms we want 
## Then the function draws the area that is needed, it randimises the width and height of the area
## After adds that as a child of the node, Rooms. This is where we will keep the rooms
func makes_areas():
	for i in range(num_rooms):
		var pos = Vector2(0,0)
		var room_instance = Room.instance()
		var width_room = room_min_size + randi() % (room_max_size - room_min_size)
		var height_room = room_min_size + randi() % (room_max_size - room_min_size)
		room_instance.make_room(pos, Vector2(width_room, height_room) * TILE_SIZE)
		$Rooms.add_child(room_instance)