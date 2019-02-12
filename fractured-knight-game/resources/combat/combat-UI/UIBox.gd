#Filename: UIBox.gd
#Breif: Draws boxes of the moves and keeps track of them.
#Creator: Vikram
#Date: 07/02/19
extends NinePatchRect

var xPos = 0.0
var yPos = 0.0

#var buttonResource = preload('res://resources/combat/combat-UI/CombatButton.tscn')
#var buttonScene = buttonResource.instance()
#var buttons = buttonScene.get_children()
var test = ["a","b","c","d"]

## uses arrow keys to move around
func _ready():
	#createBox(test)
	readArrray(test)
	#$Move1.grab_focus()
	

func _process(delta):
	find_pressed()
## reads array to place elemnt from array into box
## @param array = array of elemts that needs to be read and places into boxes
func readArrray(array):
	for item in array:
		var button = Button.new()
		button.text = item
		button.rect_position = Vector2((xPos), (yPos + 90))
		createBox(button)

func createBox(button):
	$BtnContainer.add_child(button)

func find_pressed():
	var all_Buttons = $BtnContainer.get_children()
	for item in all_Buttons:
		if(item.pressed):
			print(get_index(item.text, test))

func get_index(name, array):
	for i in range(0, array.size()):
		if(array[i] == name):
			return i
func getWidth():
	self.get_size()

## Set the postion of the cusor to the arrow so it always 
##   points at the box where the mouse curor is
func _on_Move1_mouse_entered():
	$Arrow.position.x = 59
	$Arrow.position.y = 74

func _on_Move2_mouse_entered():
	$Arrow.position.x = 59
	$Arrow.position.y = 244

func _on_Move3_mouse_entered():
	$Arrow.position.x = 1019
	$Arrow.position.y = 244

func _on_Move4_mouse_entered():
	$Arrow.position.x = 1019
	$Arrow.position.y = 74

## emits a signal of which button is pressed
func _on_Move1_pressed():
	emit_signal("Move1")

func _on_Move2_pressed():
	emit_signal("Move2")

func _on_Move3_pressed():
	emit_signal("Move3")

func _on_Move4_pressed():
	emit_signal("Move4")
