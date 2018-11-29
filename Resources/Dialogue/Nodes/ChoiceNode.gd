# Filename: ChoiceNode.gd
# Brief: 
# Author: Jamie Massey
# Created: 29/11/2018

var dialogue_node = load("res://Resources/Dialogue/DialogueNode.gd")

class ChoiceNode extends dialogue_node.DialogueNode:
	var goto = ""
	var restart = false
	
	func _init(goto, restart):
		self.goto = goto
		self.restart = restart
	
	func next(context):
		if (restart):
			context.restart()
		elif (goto != ""):
			context.redirect(goto)
		else:
			context.current = self
