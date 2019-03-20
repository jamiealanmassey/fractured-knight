extends Area2D

export (String) var dialogue_name

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass



#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		print("play dialogue from area");
		get_node('/root/LevelManager').start_dialogue(dialogue_name)
		self.queue_free()
	
