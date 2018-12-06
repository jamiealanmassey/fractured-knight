# Filename: ChoiceNode.gd
# Brief: 
# Author: Jamie Massey
# Created: 29/11/2018

extends "res://Resources/DialogueSystem/DialogueNode.gd"

var goto = ""
var restart = false
var text = ""

func _init(goto, restart):
	self.goto = goto
	self.restart = restart

func next(context):
	if (restart):
		context.restart()
	elif (goto != ""):
		context.redirect(goto)
	else:
		context.switchNode(nextNodes[0])

func get_type():
	return "choice"