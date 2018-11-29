extends Node

export(String, FILE, "*.dialogue") var dialogueFile

var file;

func _ready():
	file = XMLParser.new()
	file.open(dialogueFile)
