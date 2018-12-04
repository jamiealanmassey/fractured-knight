# Filename: ChoicesNode.gd
# Brief: Describes a collection of ChoiceNode objects defining dialogue choices that the
#        player can make
# Author: Jamie Massey
# Created: 29/11/2018

extends "res://Resources/Dialogue/DialogueNode.gd"

#var dialogue_node = load("res://Resources/Dialogue/DialogueNode.gd")

#class ChoicesNode extends dialogue_node.DialogueNode:
var choice = -1

func select(context):
	pass #' TODO: Display choices to UI
	
func continue(context):
	if (choice >= 0):
		nextNodes[choice].next(context)

func get_type():
	return "choices"
