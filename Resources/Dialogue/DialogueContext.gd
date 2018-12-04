# Filename: DialogueContext.gd
# Brief: Defines a context which describes all the potential paths in a dialogue and 
#        executes them as it progresses; also stores state information about the dialogue
# Author: Jamie Massey
# Created: 29/11/2018

extends Node

export(String, FILE, "*.dialogue") var dialogueFile

onready var line_node = preload("res://Resources/Dialogue/Nodes/LineNode.gd")
onready var location_node = preload("res://Resources/Dialogue/Nodes/LocationNode.gd")
onready var choices_node = preload("res://Resources/Dialogue/Nodes/ChoicesNode.gd")
onready var choice_node = preload("res://Resources/Dialogue/Nodes/ChoiceNode.gd")

var nodeRoot = null
var nodeCurrent = null
var xmlContext = null
var xmlNodeType = XMLParser.NODE_UNKNOWN
var locationNodes = {}
var choiceNodes = []

func _ready():
	if (dialogueFile != ""):
		parse(dialogueFile)

func _process(delta):
	pass

# Takes the specified file and linearly parses it as an XML file converting
# it into a context that resembles a graph for the dialogue system to traverse
func parse(file):
	xmlContext = XMLParser.new()
	xmlContext.open(file)
	xmlContext.read()
	xmlContext.read()
	nodeRoot = parse_node()
	nodeCurrent = nodeRoot
	
	#while (nodeCurrent != null):
	#	print(nodeCurrent.get_type())
	#	if (nodeCurrent.nextNodes[0] != null):
	#		nodeCurrent = nodeCurrent.nextNodes[0]
	#	else:
	#		nodeCurrent = null

# Parses a single node and makes a recursive call to itself if another node
# has been instantiated
func parse_node():
	xmlContext.read()
	xmlNodeType = xmlContext.get_node_type()
	var node = null
	var result = null
	var choicesFlush = false
	var node_name = xmlContext.get_node_name()
	
	if (choiceNodes.size() > 0):
		choicesFlush = true
	
	if xmlNodeType == XMLParser.NODE_ELEMENT:
		if xmlContext.get_node_name() == "line":
			node = parse_line()
		elif xmlContext.get_node_name() == "location":
			node = parse_location()
		elif xmlContext.get_node_name() == "choices":
			node = parse_choices()
		elif xmlContext.get_node_name() == "conditionals":
			parse_conditionals()
		
	if choicesFlush:
		for choice in choiceNodes:
			if (choice.goto == "" && !choice.restart):
				choice.nextNodes.push_back(node)
				
		choiceNodes.clear()
		
	xmlContext.read()
	if (node != null):
		node.nextNodes.push_back(parse_node())
	
	return node

# Parse and create a LineNode.gd
func parse_line():
	var text = ""
	xmlContext.read()
	text = xmlContext.get_node_data()
	xmlContext.read()
	var node = line_node.new(text)
	return node

# Parse and create a LocationNode.gd
func parse_location():
	var name = xmlContext.get_attribute_value(0)
	var node = location_node.new(name)
	locationNodes[name] = node
	return node

# Parse and create a ChoicesNode.gd
func parse_choices():
	xmlContext.read()
	var node = choices_node.new()
	while (xmlNodeType != XMLParser.NODE_ELEMENT_END):
		if (xmlContext.get_node_name() == "choice"):
			choiceNodes.push_back(parse_choice())
			
		xmlContext.read()
		xmlNodeType = xmlContext.get_node_type()
	
	return node
	
# Parse and create a ChoiceNode.gd
func parse_choice():
	var goto = xmlContext.get_attribute_value(0)
	var restart = bool(xmlContext.get_attribute_value(1))
	var node = choice_node.new(goto, restart)
	xmlContext.read()
	node.text = xmlContext.get_node_data()
	xmlContext.read()
	return node

## Parse and create a ConditionalsNode.gd
func parse_conditionals():
	pass
	
# Parse and create a ConditionalNode.gd
func parse_conditional():
	pass
