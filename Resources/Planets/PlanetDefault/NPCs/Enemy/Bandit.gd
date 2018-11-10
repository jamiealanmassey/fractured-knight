extends "res://Resources/Planets/PlanetDefault/NPCs/Enemy/BaseClass.gd"

var dialogue = ["Hello there!", "I am Sir Edward, a knight who owns these lands.", "If you could find my sword, then I can help you on your journey!"] 
var threats = ["Get away!", "I'll attack if you get close!"]
var dialogueProgression = 0;
var threatCounter = 0;
#Returns next bit of dialogue 
func converse():
	#TODO: add actual branching dialogue
	var currentDialogue = dialogue[dialogueProgression]
	dialogueProgression += 1
	dialogueProgression = dialogueProgression % dialogue.size()
	return currentDialogue
	
func threaten():
	var threat = threats[threatCounter]
	threatCounter += 1
	threatCounter = threatCounter % threats.size()
	return threat
	
	
func _on_DectRadius_area_entered(area):
	$SpeechOutput.text = threaten()
	pass # replace with function body
	

#player is within combat radius (has contacted player)
func _on_ContactRadius_area_entered(area):
	$SpeechOutput.text = "Initate combat"
	pass # replace with function body
