extends Node2D

onready var one_piece = get_node('../One_piece')

func _ready():
	set_process(true)
	pass

func _process(delta):
	if one_piece.check_unit():
		get_node('Light').increase()
	pass
