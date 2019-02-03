# Filename: dialogue_parser.gd
# Brief: Reads a given file and produces a DialogueContext to be used by the UI
# Author: Jamie Massey
# Created: 03/02/2019
extends Node

var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')

var stack = []
var result = []
var root = null

func parse(filename):
	var file = File.new()
	file.open(filename, file.READ)
	
	while not file.eof_reached():
		var line = file.get_line()
		result.append(line)
		
	file.close()
	construct_tree()
	


func count_num_tabs(line):
	var count = 0
	for i in line:
		if i == '\t':
			count += 1
			
	return count
	


func construct_tree():
	var current = null
	for line in result:
		var tabs = count_num_tabs(line)
		var node = DialogueNode.new(DialogueNode.NodeType.Write, [], [line.strip_edges()])
		
		if current == null:
			current = node
			root = current
		
		current.children.append(node)
		current = node
	
