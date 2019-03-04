extends Node

func _ready():
	var dialogue = get_node('/root/LevelManager/DialogueUI')
	if (dialogue != null):
		dialogue.load_symbols()
		print(dialogue.symbols)
