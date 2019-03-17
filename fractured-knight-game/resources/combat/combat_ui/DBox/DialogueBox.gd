extends Node2D

signal finished_displaying_text

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_combatInterface_display_text(text):
	$RichTextLabel.set_string(text)
	yield($RichTextLabel, "finished_displaying_text")
	emit_signal("finished_displaying_text")
	pass # replace with function body
