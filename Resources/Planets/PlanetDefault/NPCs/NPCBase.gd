extends Node2D

signal detected_player
signal lost_player
signal hit_player

export (int) var detection_radius
var player_location
var player

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$DetectionRadius/CollisionShape2D.shape.radius = detection_radius
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if (player_location != null):
		print(player_location.x)
		print(player_location.y)
		var x_diff = position.x - player_location.x
		var y_diff = position.y - player_location.y
		var x_y_ratio = x_diff/y_diff
		var vector = Vector2(x_diff, y_diff).normalized()
		print(vector.x)
		print(vector.y)
		position.x = position.x - vector.x
		position.y = position.y - vector.y
		player_location = player.position
	pass

func _on_DetectionRadius_area_entered(area):
	if (area.get_owner().get_name() == "Player"):
		player = area.get_owner()
		player_location = area.get_owner().position
		emit_signal("detected_player")
	pass # replace with function body

func _on_DetectionRadius_area_exited(area):
	if (area.get_owner().get_name() == "Player"):
		player = null
		player_location = null
		emit_signal("lost_player")
	pass # replace with function body


func _on_CollisionArea_area_entered(area):
	emit_signal("hit_player")
	pass # replace with function body
