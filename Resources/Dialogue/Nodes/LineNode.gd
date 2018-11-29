# Filename: LineNode.gd
# Brief: Defines a Line of text to be displayed in the dialogue
# Author: Jamie Massey
# Created: 29/11/2018

var dialogue_node = load("res://Resources/Dialogue/DialogueNode.gd")

class LineNode extends dialogue_node.DialogueNode:
	var text = ""
	
	func _init(text):
		self.text = text
		
	func select(context):
		# TODO: Make it so when the line is selected it changes the text in the
		# UI element
		log("LineNode: " + self.text)
		
	func continue(context):
		if (Input.is_action_pressed("ui_select")):
			self.next(context)
