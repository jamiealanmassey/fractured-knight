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
		var node = DialogueNode.new(DialogueNode.NodeType.Error, [], [], '')
		var tabs = count_num_tabs(line)
		line = line.strip_edges()
		var first_token_index = line.find(' ')
		if first_token_index == -1:
			first_token_index = line.length()
		
		var first_token = line.substr(0, first_token_index)
		var content = line.substr(first_token_index + 1, line.length() - first_token_index - 1)
		
		var metadata_left_index = first_token.find('[')
		var metadata_right_index = first_token.find(']')
		if metadata_left_index != -1 && metadata_right_index != -1:
			var metadata = first_token.substr(metadata_left_index +1, metadata_right_index - metadata_left_index -1)
			var metadata_refined = metadata.split(',')
			node.metadata = metadata_refined
			first_token = first_token.substr(0, metadata_left_index)
		
		var first_token_type = string_to_node_type(first_token)
		node.type = first_token_type
		node.content = content
		node.tabs = tabs
	
		if current == null:
			current = node
			root = current
		else:
			current.children.append(node)
			current = node
	

func string_to_node_type(token):
	token = token.to_lower()
	if token == 'write':
		return DialogueNode.NodeType.Write
	elif token == 'branch':
		return DialogueNode.NodeType.Branch
	elif token == 'locate':
		return DialogueNode.NodeType.Locate
	elif token == 'point':
		return DialogueNode.NodeType.Point
	elif token == 'trigger':
		return DialogueNode.NodeType.Trigger
	elif token == 'set':
		return DialogueNode.NodeType.Set
	elif token == 'unset':
		return DialogueNode.NodeType.Unset
	elif token == 'evaluate':
		return DialogueNode.NodeType.Evaluate
	else:
		return DialogueNode.NodeType.Error
	