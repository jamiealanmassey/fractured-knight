extends "res://Resources/Planets/PlanetDefault/NPCs/Enemy/BaseClass.gd"

var threats = ["Get away!", "I'll attack if you get close!"]
var dialogue = ["All I needed was some food..."] 
var dialogueProgression = 0;
var threatCounter = 0;

#Returns next bit of dialogue 
func converse():
	#TODO: add actual branching dialogue
	var currentDialogue = dialogue[dialogueProgression]
	dialogueProgression += 1
	dialogueProgression = dialogueProgression % dialogue.size()
	return currentDialogue

#When player enters hostile area's detection area, return text
func threaten():
	var threat = threats[threatCounter]
	threatCounter += 1
	threatCounter = threatCounter % threats.size()
	return threat
	
	
	
	
#Player is within detection radius
func _on_DectRadius_area_entered(area):
	$SpeechOutput.text = threaten()
	pass # replace with function body
	


#player is within combat radius (has contacted player)
func _on_ContactRadius_area_entered(area):
	$SpeechOutput.text = "Initate combat"
	pass # replace with function body
