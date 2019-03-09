extends RigidBody2D

## Size of room 
var size

## @param pos : position  of new room
## @param size : size of new room 
## Functuion generates a new room of the given paramters
func make_room(pos, size):
	position = pos
	size = size
	var rec = RectangleShape2D.new()
	rec.custom_solver_bias = 0.5
	rec.extents = size
	$CollisionShape2D.shape = rec

