# Filename: LocationNode.gd
# Brief: Defines a location in the tree to be jumped back to
# Author: Jamie Massey
# Created: 29/11/2018

extends "res://Resources/Dialogue/DialogueNode.gd"

#var dialogue_node = load("res://Resources/Dialogue/DialogueNode.gd")

#class LocationNode extends dialogue_node.DialogueNode:
var name = ""

func _init(name):
	self.name = name
