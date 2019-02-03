# Filename: dialogue_node.gd
# Brief: Defines a Node in the Dialogue Tree to be interpreted by the Dialogue Context
# Author: Jamie Massey
# Created: 03/02/2019
extends Node

enum NodeType {
	Write,
	Branch
}

var children = []
var metadata = []
var tabs = 0
var type = NodeType.Write

func _init(type, children, metadata):
	self.children = children
	self.metadata = metadata
	self.type = type
