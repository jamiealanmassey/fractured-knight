# Filename: ConditionalNode.gd
# Brief: Validates a given condition and assuming that condition is met, executes nodes following
# Author: Jamie Massey
# Created: 29/11/2018

var dialogue_node = load("res://Resources/Dialogue/DialogueNode.gd")

class ConditionalNode extends dialogue_node.DialogueNode:
	var condition = ""
	
	func _init():
		pass
		
	func passes():
		return true # TODO: Parse condition to see if it is met
