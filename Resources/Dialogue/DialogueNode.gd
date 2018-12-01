# Filename: DialogueNode.gd
# Brief: Defines a DialogueNode that exists in the tree and can be extended to exhibit 
#        different behaviours
# Author: Jamie Massey
# Created: 29/11/2018

var nextNodes = []
var parentNode = null

func select(context):
	pass
	
func continue(context):
	self.next(context)
	
func process(context):
	pass
	
func next(context):
	context.current = self

func get_type():
	return "unknown"
