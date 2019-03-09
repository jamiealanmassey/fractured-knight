extends Node2D

## pre-load room script to accesss that scene and methord
var Room = preload("res://resources/levels/Rooms/Procedural/room.tscn")

## gets the tilset from the tilemap in the tree
onready var Map = $TileMap

## Constants for tile_size (32 x 32)
const TILE_SIZE = 32

## varibles for number of rooms and bound for sizes
## horrosontal spread of rooms/areas and to go through and delete rooms
## paths is the where we store the path finding algo
var num_rooms = 100
var room_min_size = 4
var room_max_size = 10
var horr_spread = 500
var delete_rooms = 0.5
var path 

## Initilise the rand func 
## calls makes areas
func _ready():
	randomize()
	makes_areas()

## Updates the scene to show the areas being made in real time
func _process(delta):
	update()

func _input(event):
	if(event.is_action_pressed("ui_select")):
		map()

## Makes rooms using a for loop to cycle through the amount of rooms we want 
## Then the function draws the area that is needed, it randimises the width and height of the area
## After adds that as a child of the node, Rooms. This is where we will keep the rooms
## We yield meaning to stop and create a timer so we can alloe the program to create the rooms and store them
## Then we randomly delete some rooms (ELSE) we make them static and add the room to the arrat (pos_rooms)
## After we set a timer to wait and then call the function find_min_span_tree with @param being the array
func makes_areas():
	for i in range(num_rooms):
		var pos = Vector2(rand_range(-horr_spread, horr_spread), 0)
		var room_instance = Room.instance()
		var width_room = room_min_size + randi() % (room_max_size - room_min_size)
		var height_room = room_min_size + randi() % (room_max_size - room_min_size)
		room_instance.make_room(pos, Vector2(width_room, height_room) * TILE_SIZE)
		$Rooms.add_child(room_instance)
	yield(get_tree().create_timer(1.1), "timeout")
	var pos_rooms = []
	for n in $Rooms.get_children():
		if randf() < delete_rooms:
			n.queue_free()
		else:
			n.mode = RigidBody2D.MODE_STATIC
			pos_rooms.append(Vector3(n.position.x, n.position.y, 0))
	yield(get_tree(), "idle_frame")
	path = find_min_span_tree(pos_rooms)

## Draws a outline box for each room so we can see it
## Using rectangles to do so of colour Lime Green
func _draw():
	##for i in $Rooms.get_children():
		##draw_rect(Rect2(i.position - i.size, i.size * 2), Color(50, 205, 350), true)
	if path:
		for p in path.get_points():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cp = path.get_point_position(c)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y), Color(50,250,35), 15, true)

## This function finds the minium spanning tree by using Prims Algorithum
## creates a new AStar object as this is the way we can find the shortest distnace 
## After we loop through the array containing all the points
## This loops allows for 3 new varibles to be created:
## ## min_dis set to infinate but will hold the distances between nodes
## ## min_pos is the mininum position that the nodes is in
## ## current_pos is the varibles to keep track of where we are
## We loop through the set of points and set each point as out postition
## After we loop[ through the array of areas to see which is the closes area to each other
## Follwing the basic principle of prims algorithum
## @returns the path 
func find_min_span_tree(array):
	var path = AStar.new()
	path.add_point(path.get_available_point_id(), array.pop_front())
	while array:
		var min_dis = INF
		var min_pos = null
		var current_pos = null
		for i in path.get_points():
			i = path.get_point_position(i)
			for n in array:
				if i.distance_to(n) < min_dis:
					min_dis = i.distance_to(n)
					min_pos = n
					current_pos = i
		var neighbour =  path.get_available_point_id()
		path.add_point(neighbour, min_pos)
		path.connect_points(path.get_closest_point(current_pos), neighbour)
		array.erase(min_pos)
	return path

## First we have to workout and fill the area of the Entire map
## We use 
func map():
	Map.clear()
	var full_area_of_map = Rect2()
	for i in $Rooms.get_children():
		print(i.size)
		var rec = Rect2(i.position, i.get_node("CollisionShape2D").shape.extents*2)
		full_area_of_map = full_area_of_map.merge(rec)
	var top_left_map = Map.world_to_map(full_area_of_map.position)
	var bottom_right_map = Map.world_to_map(full_area_of_map.end)
	for nX in range(top_left_map.x, bottom_right_map.x):
		for nY in range(top_left_map.y, bottom_right_map.y):
			Map.set_cell(nX, nY, 1) # TOOD: tilemap
	for n in $Rooms.get_children():
		var r_size = (n.size / TILE_SIZE).floor()
		var pos_room = Map.world_to_map(n.position)
		var top_left = (n.position / TILE_SIZE).floor() - r_size
		for nX in range(2, r_size.x*2-1):
			for nY in range(2, r_size.y*2-1):
				Map.set_cell(top_left.x+nX, top_left.y+nY, 0)