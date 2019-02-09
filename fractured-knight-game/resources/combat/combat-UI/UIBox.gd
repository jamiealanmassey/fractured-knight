#Filename: UIBox.gd
#Breif: Draws boxes of the moves and keeps track of them.
#Creator: Vikram
#Date: 07/02/19
extends NinePatchRect

var box

func _ready():
	pass

func drawBox():
	# create connection to system
	box = add_child(Label.new())
	