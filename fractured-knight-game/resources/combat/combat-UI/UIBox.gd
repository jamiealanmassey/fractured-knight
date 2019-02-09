#Filename: UIBox.gd
#Breif: Draws boxes of the moves and keeps track of them.
#Creator: Vikram
#Date: 07/02/19
extends NinePatchRect

## uses arrow keys to move around
func _ready():
	$Move1.grab_focus()

## reads array to place elemnt from array into box
## @param array = array of elemts that needs to be read and places into boxes
func readArrray(array):
	for i in range(0, array.size()):
		if(i == 0):
			$Move1.set_text(array[i])
		elif(i == 1):
			$Move2.set_text(array[i])
		elif(i == 2):
			$Move3.set_text(array[i])
		elif(i == 3):
			$Move4.set_text(array[i])

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
