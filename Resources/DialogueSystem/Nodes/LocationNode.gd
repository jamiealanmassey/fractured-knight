# Filename: LocationNode.gd
# Brief: Defines a location in the tree to be jumped back to
# Author: Jamie Massey
# Created: 29/11/2018

extends "res://Resources/DialogueSystem/DialogueNode.gd"

var locationName = ""

func _init(locationName):
	self.locationName = locationName

func get_type():
	return "location"
