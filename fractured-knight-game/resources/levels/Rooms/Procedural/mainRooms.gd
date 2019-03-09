extends Node2D

## pre-load room script to accesss that scene and methord
var Room = preload("res://resources/levels/Rooms/Procedural/room.tscn")

## Constants for tile_size (32 x 32)
const TILE_SIZE = 32

## varibles for number of rooms and bound for sizes
## horrosontal spread of rooms/areas and to go through and delete rooms
var num_rooms = 10
var room_min_size = 4
var room_max_size = 10
var horr_spread = 300
var delete_rooms = 0.5


## Initilise the rand func 
## calls makes areas
func _ready():
	randomize()
	makes_areas()

## Updates the scene to show the areas being made in real time
func _process(delta):
	update()

## Makes rooms using a for loop to cycle through the amount of rooms we want 
## Then the function draws the area that is needed, it randimises the width and height of the area
## After adds that as a child of the node, Rooms. This is where we will keep the rooms
## We yield meaning to stop and create a timer so we can alloe the program to create the rooms and store them
## Then we randomly delete some rooms (ELSE) we make them static
func makes_areas():
	for i in range(num_rooms):
		var pos = Vector2(rand_range(-horr_spread, horr_spread), 0)
		var room_instance = Room.instance()
		var width_room = room_min_size + randi() % (room_max_size - room_min_size)
		var height_room = room_min_size + randi() % (room_max_size - room_min_size)
		room_instance.make_room(pos, Vector2(width_room, height_room) * TILE_SIZE)
		$Rooms.add_child(room_instance)
	yield(get_tree().create_timer(1.1), "timeout")
	for n in $Rooms.get_children():
		if randf() < delete_rooms:
			n.queue_free()
		else:
			n.mode = RigidBody2D.MODE_STATIC

## Draws a outline box for each room so we can see it
## Using rectangles to do so of colour Lime Green
func _draw():
	for i in $Rooms.get_children():
		draw_rect(Rect2(i.position - i.size, i.size * 2), Color(50, 205, 350), true)