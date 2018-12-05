extends "res://Resources/Planets/PlanetDefault/NPCs/Enemy/BaseClass.gd"

signal detectedPlayer



var dialogue = ["Hello there!", "I am Sir Edward, a knight who owns these lands.", "If you could find my sword, then I can help you on your journey!"] 
var dialogueProgression = 0;

#Radius where NPC will detect player


func _ready():
	$DectRadius/CollisionShape2D.shape.radius = detectionRadius


#Returns next bit of dialogue 
func converse():
	#TODO: add actual branching dialogue
	var currentDialogue = dialogue[dialogueProgression]
	dialogueProgression += 1
	dialogueProgression = dialogueProgression % dialogue.size()
	return currentDialogue
	
	
	
	

func _on_DectRadius_area_entered(area):
	$SpeechOutput.text = converse()
	pass # replace with function body
