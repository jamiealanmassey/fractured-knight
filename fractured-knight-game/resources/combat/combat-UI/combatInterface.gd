extends Control

signal get_ready
signal btnPressed
signal display_text
signal finished_displaying_text

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Combat_UI_get_ready():
	emit_signal("get_ready")
	pass # replace with function body


func _on_Combat_show_fighting_options(moves):
	$UIBox._on_Combat_show_fighting_options(moves)
	pass # replace with function body


func _on_Combat_show_menu_options():
	$UIBox._on_Combat_show_menu_options()
	pass # replace with function body


func _on_UIBox_btnPressed(button_pressed):
	emit_signal("btnPressed", button_pressed)
	pass # replace with function body


func _on_Combat_display_text(text):
	emit_signal("display_text", text)
	# need to wait for text to be displayed
	yield($DialogueBox, "finished_displaying_text")
	emit_signal("finished_displaying_text")
	pass # replace with function body
	


func _on_Combat_combat_finished():
	#Use this function to hide buttons etc. Wrap up combat
	print("combat finished signal recieved")
	$UIBox.hide()
	pass # replace with function body
