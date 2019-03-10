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
const TILE_SIZE = 32  
var num_rooms = 50 
var min_size = 6  
var max_size = 15  
var hspread = 400  
var delete_rooms = 0.5  
var path 
var start_room = null
var end_room = null

## Initilise the rand func 
## calls makes areas
func _ready():
	randomize()
	make_areas()

## Updates the scene to show the areas being made in real time
func _process(delta):
	update()

## Makes rooms using a for loop to cycle through the amount of rooms we want 
## Then the function draws the area that is needed, it randimises the width and height of the area
## After adds that as a child of the node, Rooms. This is where we will keep the rooms
## We yield meaning to stop and create a timer so we can alloe the program to create the rooms and store them
## Then we randomly delete some rooms (ELSE) we make them static and add the room to the arrat (pos_rooms)
## After we set a timer to wait and then call the function find_min_span_tree with @param being the array
func make_areas():
	for i in range(num_rooms):
		var pos = Vector2(rand_range(-hspread, hspread), 0)
		var r = Room.instance()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * TILE_SIZE)
		$Rooms.add_child(r)
	yield(get_tree().create_timer(1.1), 'timeout')
	var pos_rooms = []
	for r in $Rooms.get_children():
		if randf() < delete_rooms:
			r.queue_free()
		else:
			r.mode = RigidBody2D.MODE_STATIC
			pos_rooms.append(Vector3(r.position.x, r.position.y, 0))
	yield(get_tree(), 'idle_frame')
	path = find_min_span_tree(pos_rooms)
	map()

## Draws paths to conect the rooms but draww the lines stright
## we check if the path is complete then we draw the line
func _draw():
	if path:
		for point in path.get_points():
			for connection in path.get_point_connections(point):
				var pp = path.get_point_position(point)
				var cp = path.get_point_position(connection)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y), Color(0, 225, 0), 15, true)

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
		for p1 in path.get_points():
			p1 = path.get_point_position(p1)
			for p2 in array:
				if p1.distance_to(p2) < min_dis:
					min_dis = p1.distance_to(p2)
					min_pos = p2
					current_pos = p1
		var neighbour = path.get_available_point_id()
		path.add_point(neighbour, min_pos)
		path.connect_points(path.get_closest_point(current_pos), neighbour)
		array.erase(min_pos)
	return path

## First we have to workout and fill the area of the Entire map
## We use the merge function built into TileMap to merge the size of the area taken up by the nodes
## Then we use the full_area_of to get the top left ps and the botton left pos, with this we create a grid a 2D grid using indented for loops
## The first set of loops set the full map tileset
## The second set of loops use the rooms stored in the Rooms node to set the tilemap and get the area of each and drawe the tileset accoring to that
## there are 3 local varibles made : to keep track of the size of each room, position of it in the world, top left position in each room
## After we use the same loop to connect rooms as they are being drawn with the tilemap
func map():
	Map.clear()
	var full_rect = Rect2()
	for room in $Rooms.get_children():
		var r = Rect2(room.position-room.size,
					room.get_node("CollisionShape2D").shape.extents*2)
		full_rect = full_rect.merge(r)
	var topleft = Map.world_to_map(full_rect.position)
	var bottomright = Map.world_to_map(full_rect.end)
	for x in range(topleft.x, bottomright.x):
		for y in range(topleft.y, bottomright.y):
			Map.set_cell(x, y, 1)	
	var hall = [] 
	for room in $Rooms.get_children():
		var s = (room.size / TILE_SIZE).floor()
		var pos = Map.world_to_map(room.position)
		var ul = (room.position / TILE_SIZE).floor() - s
		for x in range(2, s.x * 2 - 1):
			for y in range(2, s.y * 2 - 1):
				Map.set_cell(ul.x + x, ul.y + y, 0)
		var p = path.get_closest_point(Vector3(room.position.x, room.position.y, 0))
		for conn in path.get_point_connections(p):
			if not conn in hall:
				var start = Map.world_to_map(Vector2(path.get_point_position(p).x, path.get_point_position(p).y))
				var end = Map.world_to_map(Vector2(path.get_point_position(conn).x, path.get_point_position(conn).y))									
				draw_path(start, end)
		hall.append(p)

## @param pos1 : the starting position
## @param pos2 : the ending positon
## Drawing the path between rooms/areas to connect them up
## We first find the diffrence in the 2 positions we are given 
func draw_path(pos1, pos2):
	var delta_x = sign(pos2.x - pos1.x)
	var delta_y = sign(pos2.y - pos1.y)
	if delta_x == 0: delta_x = pow(-1.0, randi() % 2)
	if delta_y == 0: delta_y = pow(-1.0, randi() % 2)
	var x_to_y = pos1
	var y_to_x = pos2
	if (randi() % 2) > 0:
		x_to_y = pos2
		y_to_x = pos1
	for x in range(pos1.x, pos2.x, delta_x):
		Map.set_cell(x, x_to_y.y, 0)
		Map.set_cell(x, x_to_y.y + delta_y, 0)  
	for y in range(pos1.y, pos2.y, delta_y):
		Map.set_cell(y_to_x.x, y, 0)
		Map.set_cell(y_to_x.x + delta_x, y, 0)