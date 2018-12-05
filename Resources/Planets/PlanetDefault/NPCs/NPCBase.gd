extends Node2D

signal detected_player
signal lost_player
signal hit_player

export (int) var detection_radius
var player_location
var player
var is_interacting = false
var in_combat = false

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$DetectionRadius/CollisionShape2D.shape.radius = detection_radius
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if (player_location != null && !is_interacting):
		var x_diff = position.x - player_location.x
		var y_diff = position.y - player_location.y
		var vector = Vector2(x_diff, y_diff).normalized()
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
	if (area.get_owner().get_name() == "Player"):
		print("Area entered by player")
		var UI = get_tree().get_root().find_node("UI", true, false)
		get_tree().get_root().find_node("UI", true, false).get_node("Panel").show()
		#UI.change_to_combat()
		get_tree().get_root().find_node("UI", true, false).change_to_combat()
		is_interacting = true
	pass # replace with function body

#attack chosen
func _on_UI_option_1_chosen():
	if (is_interacting && !in_combat):
		print("NPC begins fighting player")
		in_combat = true
		emit_signal("hit_player")
	pass # replace with function body

#talk chosen
func _on_UI_option_2_chosen():
	#TODO: Add conversation here
	pass # replace with function body

#Flee chosen
func _on_UI_option_3_chosen():
	#TODO: Figure out what to do here
	pass # replace with function body
