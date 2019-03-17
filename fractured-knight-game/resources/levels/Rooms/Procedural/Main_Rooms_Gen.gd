extends Node2D
## pre-load room script to accesss that scene and method
## pre-load player to be able to access it in the scsne
var Room = preload("res://resources/levels/Rooms/Procedural/room.tscn")
onready var player = preload("res://resources/player/player.tscn")

## gets the tilset from the tilemap in the tree
onready var Map = $TileMap

## Constants for tile_size (32 x 32)
const TILE_SIZE = 32

## Exported variables for number of rooms and bound for sizes
## Horizontal spread of rooms/areas and to go through and delete rooms
export(int) var num_rooms = 10 
export(int) var room_min_size = 10  
export(int) var room_max_size = 25  
export(int) var hspread = 300  
export(float) var delete_rooms = 0.0
export(Texture) var tilemap

## Varibles for the paths and to keep the rooms and certain parts of the data in
var path 
var sceneOn = false
var starting_room = null
var end_room = null
var set_name

## Initilise the rand func 
## calls makes areas
func _ready():
	$TileMap.tile_set = tilemap
	randomize()
	make_areas()
	

func init(rooms, x_size, y_size, name):
	num_rooms = rooms
	room_min_size = x_size
	room_max_size = y_size
	set_name = name

## Updates the scene to show the areas being made in real time
func _process(delta):
	update()

## Makes rooms using a for loop to cycle through the amount of rooms we want 
## Then the function draws the area that is needed, it randomises the width and height of the area
## After adds that as a child of the node, Rooms. This is where we will keep the rooms
## We yield meaning to stop and create a timer so we can alloe the program to create the rooms and store them
## Then we randomly delete some rooms (ELSE) we make them static and add the room to the array (pos_rooms)
## After we set a timer to wait and then call the function find_min_span_tree with @param being the array
func make_areas():
	for i in range(num_rooms):
		var pos = Vector2(rand_range(-hspread, hspread), 0)
		var instance_room = Room.instance()
		var room_width = room_min_size + randi() % (room_max_size - room_min_size)
		var room_height = room_min_size + randi() % (room_max_size - room_min_size)
		instance_room.make_room(pos, Vector2(room_width, room_height) * TILE_SIZE)
		$Rooms.add_child(instance_room)
	yield(get_tree().create_timer(1.1), 'timeout')
	var pos_rooms = []
	for room in $Rooms.get_children():
		if(randf() < delete_rooms):
			room.queue_free()
		else:
			room.mode = RigidBody2D.MODE_STATIC
			pos_rooms.append(Vector3(room.position.x, room.position.y, 0))
	yield(get_tree(), 'idle_frame')
	path = find_min_span_tree(pos_rooms)
	map()
	player()
	#save_game_scene()


## Draws paths to conect the rooms but draww the lines stright
## we check if the path is complete then we draw the line
func _draw():
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2),
				 Color(0, 1, 0), false)
	if path:
		for p in path.get_points():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cp = path.get_point_position(c)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y),
						  Color(1, 1, 0), 15, true)

## This function finds the minimum spanning tree by using Prims Algorithum
## creates a new AStar object as this is the way we can find the shortest distnace 
## After we loop through the array containing all the points
## This loops allows for 3 new varibles to be created:
## ## min_dis set to infinate but will hold the distances between nodes
## ## min_pos is the mininum position that the nodes is in
## ## current_pos is the varibles to keep track of where we are
## We loop through the set of points and set each point as out postition
## After we loop through the array of areas to see which is the closest area to each other
## Following the basic principle of prims algorithm
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
				if(p1.distance_to(p2) < min_dis):
					min_dis = p1.distance_to(p2)
					min_pos = p2
					current_pos = p1
		var neighbour = path.get_available_point_id()
		path.add_point(neighbour, min_pos)
		path.connect_points(path.get_closest_point(current_pos), neighbour)
		array.erase(min_pos)
	return path

## First we have to workout and fill the area of the entire map
## We use the merge function built into TileMap to merge the size of the area taken up by the nodes
## Then we use the full_area_of to get the top left pos and the botton left pos, with this we create a grid a 2D grid using  for loops
## The first set of loops set the full map tileset
## The second set of loops use the rooms stored in the Rooms node to set the tilemap and get the area of each and draw the tileset accoring to that
## there are 3 local varibles made : to keep track of the size of each room, position of it in the world, top left position in each room
## After we use the same loop to connect rooms as they are being drawn with the tilemap
func map():
	Map.clear()
	finding_rooms()
	var full_rect = Rect2()
	for room in $Rooms.get_children():
		var r = Rect2(room.position-room.size, room.get_node("CollisionShape2D").shape.extents*2)
		print(r) # REMOVE
		full_rect = full_rect.merge(r)
	var topleft = Map.world_to_map(full_rect.position)
	var bottomright = Map.world_to_map(full_rect.end)
	for x in range(topleft.x, bottomright.x):
		for y in range(topleft.y, bottomright.y):
			Map.set_cell(x, y, 1)
	var hall = [] 
	for room in $Rooms.get_children():
		var room_size = (room.size / TILE_SIZE).floor()
		var room_pos = Map.world_to_map(room.position)
		var top_left = (room.position / TILE_SIZE).floor() - room_size
		for x in range(2, room_size.x * 2 - 1):
			for y in range(2, room_size.y * 2 - 1):
				Map.set_cell(top_left.x + x, top_left.y + y, 0)
				if(x == (randi()%11+1)):
					Map.set_cell(top_left.x + x, top_left.y + y, 0)
		var p = path.get_closest_point(Vector3(room.position.x, room.position.y, 0))
		for cc in path.get_point_connections(p):
			if(not cc in hall):
				var start = Map.world_to_map(Vector2(path.get_point_position(p).x, path.get_point_position(p).y))
				var end = Map.world_to_map(Vector2(path.get_point_position(cc).x, path.get_point_position(cc).y))
				draw_path(start, end)
		hall.append(p)

## @param pos1 : the starting position
## @param pos2 : the ending positon
## Drawing the path between rooms/areas to connect them up
## We first find the diffrence in the 2 positions we are given 
func draw_path(pos1, pos2):
	var delta_x = sign(pos2.x - pos1.x)
	var delta_y = sign(pos2.y - pos1.y)
	if(delta_x == 0): 
		delta_x = pow(-1.0, randi() % 2)
	if(delta_y == 0): 
		delta_y = pow(-1.0, randi() % 2)
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

## This function finds the starting room and ending room from all the rooms store in the node Rooms
## We set the lower bound and the higest bound of the map on the X plane
## Then the function searches for the the lowest bounded room and then the highest for start and end points
func finding_rooms():
	var x_lowest_bound = INF
	var x_highest_bound = -INF
	for room in $Rooms.get_children():
		if(room.position.x < x_lowest_bound):
			starting_room = room
			x_lowest_bound = room.position.x
	for room in $Rooms.get_children():
		if(room.position.x > x_highest_bound):
			end_room = room
			x_highest_bound = room.position.x

func player():
	var play = player.instance()
	add_child(play)
	$Player.position = starting_room.position
	

## Saving scene state using PackedScene
## saves game into folder
func save_game_scene():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("res://resources/levels/Rooms/Temp_resource_saver/" + str(set_name) + ".tscn", packed_scene)
