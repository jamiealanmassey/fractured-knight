# Filename: dialogue_node.gd
# Brief: Defines a Node in the Dialogue Tree/Graph to be interpreted by the Dialogue Context
# Author: Jamie Massey
# Created: 03/02/2019
extends Node

enum NodeType {
	Error,
	Write,
	Branch,
	Locate,
	Point,
	Trigger,
	Set,
	Unset,
	Evaluate
}

var children = []
var metadata = []
var tabs = 0
var type = NodeType.Write
var content = ''

func _init(type, children, metadata, content):
	self.children = children
	self.metadata = metadata
	self.type = type
	self.content = content