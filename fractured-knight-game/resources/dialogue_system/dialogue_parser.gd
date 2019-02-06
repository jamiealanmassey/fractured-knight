# Filename: dialogue_parser.gd
# Brief: Reads a given file and produces a DialogueContext to be used by the UI
# Author: Jamie Massey
# Created: 03/02/2019
extends Node

var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')

const node_type_map = {}

var state_stack = []  ## The stack tracks how deeply nested we currently are into a branch/evaluation
var state_list = []   ## The list keeps track of end nodes at the same depth
var result = []       ## Stores a collection of string from each line of a file
var result_nodes = [] ## Stores a linear collection of generated nodes (in order of file by line)
var root = null       ## First generated node linking to the rest of the tree

## Uses the passed file to try and parse its data into an array of strings which can then be used
## to create a DialogueTree used in a DialogueContext
func parse(filename):
	var file = File.new()
	file.open(filename, file.READ)
	
	while not file.eof_reached():
		var line = file.get_line()
		result.append(line)
		
	file.close()
	construct_tree()

## Creates a tree from each line given in the Markup Language file by going from line-to-line
## and determining what each node does
func construct_tree():
	var last_node = null
	var tab_depth = 0
	for line in result:
		if line.length() > 0 && line[0] == '#':
			continue
		
		if line.length() == 0 && state_stack.size() > 0:
			state_list.append(last_node)
			last_node = state_stack.front()
			continue
		elif line.length() == 0:
			continue
		
		var comment_occurance = line.find('#')
		if comment_occurance != -1:
			line = line.substr(0, comment_occurance)
		
		var node = construct_node(line)
		if node.tabs > tab_depth:
			tab_depth = node.tabs
			state_stack.push_front(last_node)
			last_node.children.append(node)
			last_node = node
		elif state_stack.size() > 0 && node.tabs == tab_depth:
			last_node.children.append(node)
			last_node = node
		elif state_stack.size() > 0 && node.tabs < tab_depth:
			tab_depth = node.tabs
			last_node = node
			
			var stack_node = state_stack.pop_front()
			if stack_node.type == DialogueNode.NodeType.Evaluate:
				stack_node.children.append(node)
			
			for index in range(0, state_list.size()):
				state_list[index].children.append(node)
			
			state_list.clear()
		elif last_node == null:
			last_node = node
			root = node
		else:
			last_node.children.append(node)
			last_node = node
			
		result_nodes.append(node)

## Helper method that constructs and returns a single generated node based on the passed line
## to be parsed
func construct_node(line):
	var node = DialogueNode.new(DialogueNode.NodeType.Error, [], [], '')
	var tabs = count_num_tabs(line)
	line = line.strip_edges()
	
	var metadata_left_index = line.find('[')
	var metadata_right_index = line.find(']')
	var first_token_index = line.find(' ', max(0, metadata_right_index))
	if first_token_index == -1:
		first_token_index = line.length()
	
	var first_token = line.substr(0, first_token_index)
	if metadata_left_index != -1 && metadata_right_index != -1:
		var metadata = first_token.substr(metadata_left_index +1, metadata_right_index - metadata_left_index -1)
		var metadata_refined = metadata.split(',')
		node.metadata = strip_metadata(metadata_refined)
		first_token = first_token.substr(0, metadata_left_index)
		first_token_index = metadata_right_index
	
	node.type = string_to_node_type(first_token)
	node.content = line.substr(first_token_index + 1, line.length() - first_token_index - 1)
	node.tabs = tabs
	return node

## Helper method that iterates through metadata and strips whitespaces from edges
func strip_metadata(metadata_list):
	for i in range(0, metadata_list.size()):
		metadata_list[i] = metadata_list[i].strip_edges()
	
	return metadata_list

## Helper method that takes the current line and counts how many tabs are before
## the line to be parsed then returns that number as an integer
func count_num_tabs(line):
	var count = 0
	var num_tabs = 0
	for character in line:
		if character == ' ':
			count += 1
			if count == 3:
				count = 0
				num_tabs += 1
		else:
			break
		
	return num_tabs

## Helper method that takes the found token represented as a string and convert the token
## to an Enum object corresponding to the one stored in DialogueNode.NodeType
## -> see dialogue_node.gd
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
	