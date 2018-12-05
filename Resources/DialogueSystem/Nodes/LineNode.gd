# Filename: LineNode.gd
# Brief: Defines a Line of text to be displayed in the dialogue
# Author: Jamie Massey
# Created: 29/11/2018

extends "res://Resources/DialogueSystem/DialogueNode.gd"

var text = ""

func _init(text):
	self.text = text
	
func select(context):
	get_tree().get_root().find_node("UI", true, false).set_text(self.text)
	
func continue(context):
	if (Input.is_action_just_pressed("ui_accept")):
		self.next(context)

func get_type():
	return "line"
