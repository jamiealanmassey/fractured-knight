#Filename: UIBox.gd
#Breif: Draws boxes of the moves and keeps track of them.
#Creator: Vikram
#Date: 07/02/19
extends NinePatchRect

signal btnPressed

var xPos = 0.0
var yPos = 0.0
var array

## uses arrow keys to move around
func _ready():
	#createBox(test)
	pass
	#$Move1.grab_focus()

func _process(delta):
	find_pressed()
## reads array to place elemnt from array into box
## @param array = array of elemts that needs to be read and places into boxes
func read_array(array):
	self.array = array
	for item in array:
		var button = Button.new()
		button.show()
		button.text = item
		button.rect_position = Vector2((xPos), (yPos + 90))
		$BtnContainer.add_child(button)

func find_pressed():
	var all_Buttons = $BtnContainer.get_children()
	for item in all_Buttons:
		if(item.pressed):
			emit_signal("btnPressed", (get_index(item.text, array)))
			for children in all_Buttons:
				$BtnContainer.remove_child(children)

func get_index(name, array):
	for i in range(0, array.size()):
		if(array[i] == name):
			return i

	
func _on_Combat_show_fighting_options(moves):
	var move_names = []
	for move in moves:
		move_names.append(move.move_name)
	read_array(move_names)
	pass # replace with function body


func _on_Combat_show_menu_options():
	var menu_options = ["fight", "flee"]
	read_array(menu_options)
	pass # replace with function body

# Takes an array of strings and displays them in buttons
func display_options(options):
	read_array(options)
	pass


func _on_Combat_UI_get_ready():
	show()
	_on_Combat_show_menu_options()
	pass # replace with function body
