# Filename: DialogueContext.gd
# Brief: Defines a context which describes all the potential paths in a dialogue and 
#        executes them as it progresses; also stores state information about the dialogue
# Author: Jamie Massey
# Created: 29/11/2018

extends Node

var nodeRoot = null
var nodeCurrent = null
var conditionalLast = null
var locationNodes = {}
var xmlStack = []
var xmlContext = null

func _ready():
	pass

func _process(delta):
	pass

func loadDialogue(file):
	nodeRoot = create(file)
	nodeCurrent = nodeRoot

func create(file):
	xmlContext = XMLParser.new()
	xmlContext.open(file)
	
