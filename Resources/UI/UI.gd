extends CanvasLayer

signal option_1_chosen
signal option_2_chosen
signal option_3_chosen
signal option_4_chosen


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (int) var x;
export (int) var y;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func on_new_choice():
	#called when a new choice is needed
	#
	pass

#damage as percentage value
func on_damage_recieved(damage):
	#Update damage bar here
	$Panel/VBoxContainer/HealthBar.rect_size.x = $Panel/VBoxContainer/HealthBar.rect_size.x - damage
	#adjust health bar width based on the amount of damage taken
	pass




#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button1_pressed():
	emit_signal("option_1_chosen")
	pass # replace with function body


func _on_Button2_pressed():
	emit_signal("option_2_chosen")
	pass # replace with function body


func _on_Button3_pressed():
	emit_signal("option_3_chosen")
	pass # replace with function body


func _on_Button4_pressed():
	emit_signal("option_3_chosen")
	pass # replace with function body
