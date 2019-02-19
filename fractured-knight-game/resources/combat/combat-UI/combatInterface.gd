extends Control

signal get_ready
signal btnPressed
signal display_text

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
	pass # replace with function body
