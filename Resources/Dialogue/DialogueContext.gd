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
var conditionalLast = null
var locationNodes = {}
var xmlStack = []
var xmlContext = null
var xmlNodeType = XMLParser.NODE_UNKNOWN

var lastNodes = []

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
	xmlNodeType = xmlContext.get_node_type()
	
	var lastNode = null
	var lastDepth = []
	var lastDepthNode = []
	
	var choiceNext = false
	var choiceNodes = []
	var conditionNodes = []
	
	while (xmlNodeType != XMLParser.NODE_NONE):
		# Parse current node
		var node = null
		if (xmlContext.get_node_name() == "line"):
			node = line_node.new(xmlContext.get_node_data())
		elif (xmlContext.get_node_name() == "location"):
			node = location_node.new(xmlContext.get_attribute_value(0))
			locationNodes[xmlContext.get_attribute_value(0)] = node
		elif (xmlContext.get_node_name() == "choices"):
			node = choices_node.new()
			lastDepth.push_front(xmlStack.size())
			lastDepthNode.push_front(node)
			choiceNodes.clear()
		elif (xmlContext.get_node_name() == "choice" && xmlStack.front() is choices_node):
			var goto = xmlContext.get_attribute_value(0)
			var restart = bool(xmlContext.get_attribute_value(1))
			node = choice_node.new(goto, restart)
			choiceNodes.push_back(node)
		
		# If there are any choiceNodes and the choice block has finished
		# we must set the next parsed node as the child of each valid choice node
		if (choiceNext == true):
			for choice in choiceNodes:
				if (choice.goto == "" && !choice.restart):
					choice.nextNodes.push_back(node)
			
			choiceNext = false
		
		# Assign lastNode and add new child
		if (node != null):
			lastNode = node
			lastNode.nextNodes.push_back(node)
			
			if (nodeRoot == null):
				nodeRoot = node
				nodeCurrent = node
		
		# Assign the next node to evaluate
		xmlContext.read()
		xmlNodeType = xmlContext.get_node_type()
		
		# Update the stack so we know how deep we are
		if (xmlNodeType != XMLParser.NODE_NONE && xmlNodeType != XMLParser.NODE_ELEMENT_END):
			xmlStack.push_front(xmlNodeType)
		elif (xmlNodeType == XMLParser.NODE_ELEMENT_END):
			if (lastDepth.size() > 0 && lastDepthNode.front() is choices_node):
				choiceNext = true
				lastDepth.pop_front()
				lastDepthNode.pop_front()
			
			xmlStack.pop_front()

func parse_node():
	xmlContext.read()
	xmlNodeType = xmlContext.get_node_type()
	var node = null
	var result = null
	
	if (choiceNodes.size() > 0):
		for choice in choiceNodes:
			if (choice.goto == "" && !choice.restart):
				node.nextNodes.push_back(choice)
	
	if xmlNodeType == XMLParser.NODE_ELEMENT:
		if xmlContext.get_node_name() == "line":
			node = parse_line()
		elif xmlContext.get_node_name() == "choices":
			node = parse_choices()[0]
		elif xmlContext.get_node_name() == "conditionals":
			parse_conditionals()
		
	if (node != null):
		parse_node().nextNodes.push_back(node)
	
	return node

func parse_line():
	var text = ""
	xmlContext.read()
	text = xmlContext.get_node_value()
	xmlContext.read()
	var node = line_node.new(text)
	return node

func parse_choices():
	var choices = []
	while (xmlNodeType != XMLParser.NODE_ELEMENT_END):
		if (xmlContext.get_node_name() == "choice"):
			choices.push_back(parse_choice(node))
			
		xmlContext.read()
		xmlNodeType = xmlContext.get_node_type()
	
	return [node, choices]
	
func parse_choice():
	var goto = xmlContext.get_attribute_value(0)
	var restart = bool(xmlContext.get_attribute_value(1))
	var node = choice_node.new(goto, restart)
	xmlContext.read()
	node.text = xmlContext.get_node_value()
	xmlContext.read()

func parse_conditionals():
	pass
	
func parse_conditional():
	pass
