extends Control

signal get_ready
signal btnPressed
signal display_text
signal finished_displaying_text

func _ready():
	pass
	

func _on_Combat_UI_get_ready():
	emit_signal("get_ready")
	

func _on_UIBox_btnPressed(button_pressed):
	emit_signal("btnPressed", button_pressed)
	

func _on_Combat_display_text(text):
	emit_signal("display_text", text)
	# need to wait for text to be displayed
	yield($DialogueBox, "finished_displaying_text")
	emit_signal("finished_displaying_text")
	

func _on_Combat_combat_finished(player, enemy, state):
	#Use this function to hide buttons etc. Wrap up combat
	print("combat finished signal recieved")
	$UIBox.hide()
	

func _on_Combat_display_options(options):
	$UIBox.display_options(options)
	
