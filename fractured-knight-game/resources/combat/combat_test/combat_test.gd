extends Node



func _ready():
	var combat = load("res://resources/combat/combat_core/combat.tscn").instance()
	add_child(combat)
	
	combat.start_combat($player, $enemy)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
