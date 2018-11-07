extends "res://Resources/Planets/PlanetDefault/NPCs/Enemy/BaseClass.gd"

var dialogue = ["Hello there!", "I am Sir Edward, a knight who owns these lands.", "If you could find my sword, then I can help you on your journey!"] 
var dialogueProgression = 0;

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
	
	