# Filename: ConditionalsNode.gd
# Brief: Describes a collection of ConditionNode objects until either a condition is 
#        satisfied or none of the conditions are satisfied
# Author: Jamie Massey
# Created: 29/11/2018

extends "res://Resources/DialogueSystem/DialogueNode.gd"

func next(context):
	for condition in nextNodes:
		if (condition is ConditionalNode && condition.passes()):
			condition.next(context)
				
	if (context.conditionalSkip != null):
		context.conditionalSkip.next(context)
	else:
		context.finish()

func get_type():
	return "conditionals"
