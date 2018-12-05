extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (int) var entrance_x
export (int) var entrance_y

export (int) var exit_x
export (int) var exit_y

signal entrance_entered
signal exit_entered

signal exit_exited
signal entrance_exited

func _ready():
	$Entrace.position.x = entrance_x
	$Entrace.position.y = entrance_y
	
	$Exit.position.x = exit_x
	$Exit.position.y = exit_y
	pass



#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Entrace_area_entered(area):
	print("Entrance entered")
	emit_signal("entrance_entered", $Exit.position)
	pass # replace with function body


func _on_Exit_area_entered(area):
	emit_signal("exit_entered", $Entrace.position)
	pass # replace with function body


func _on_Exit_area_exited(area):
	emit_signal("exit_exited")
	pass # replace with function body
	

func _on_Entrace_area_exited(area):
	emit_signal("entrance_exited")
	pass # replace with function body
