extends NinePatchRect

var combatUi = false
var open = false

func _ready():
	set_process_unhandled_key_input(true)
	set_fixed_process(true)
	

func _fixed_process(delta):
	if open == true:
		if menu == true: 
			set_hidden(true) 
			open = false
		menu = false 
		
func _unhandled_key_input(event):
	if open == true:
		if key_event.is_action_pressed("ui_right"):
			menu = true
			