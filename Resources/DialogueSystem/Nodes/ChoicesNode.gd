# Filename: ChoicesNode.gd
# Brief: Describes a collection of ChoiceNode objects defining dialogue choices that the
#        player can make
# Author: Jamie Massey
# Created: 29/11/2018

extends "res://Resources/DialogueSystem/DialogueNode.gd"

onready var ui = get_tree().get_root().find_node("UI", true, false)
onready var choice_node = preload("res://Resources/DialogueSystem/Nodes/ChoiceNode.gd")

var choice = -1

func select(context):
	ui.connect("option_1_chosen", self, "_react_option_1")
	ui.connect("option_2_chosen", self, "_react_option_2")
	ui.connect("option_3_chosen", self, "_react_option_3")
	ui.connect("option_4_chosen", self, "_react_option_4")
	
	for i in nextNodes.size():
		if (nextNodes[i] is choice_node):
			ui.set_button_label(i, nextNodes[i].text)
	
func continue(context):
	if (choice >= 0):
		self.next(context)
	
func next(context):
	if (nextNodes[choice] != null):
		ui.disconnect("option_1_chosen", self, "_react_option_1")
		ui.disconnect("option_2_chosen", self, "_react_option_2")
		ui.disconnect("option_3_chosen", self, "_react_option_3")
		ui.disconnect("option_4_chosen", self, "_react_option_4")
		context.switchNode(nextNodes[choice])

func get_type():
	return "choices"

func _react_option_1(ui):
	choice = 0

func _react_option_2(ui):
	choice = 1
	
func _react_option_3(ui):
	choice = 2

func _react_option_4(ui):
	choice = 3
