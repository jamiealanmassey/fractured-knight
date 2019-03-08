# Filename: dialogue_context.gd
# Brief: Holds a collection of key-pair dialogue graphs and processes through them appropriately
# Author: Jamie Massey
# Created: 13/02/2019
extends Node

enum WriteState {
	WriteNone,
	WriteProcess,
	WriteContinue
}

var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')
var DialogueParser = load('res://resources/dialogue_system/dialogue_parser.gd')

export (Array, String) var dialogue_file_names = []
export (Array, String) var dialogue_file_locations = []

var current_node = null                ## Current node active in the context from the currently active dialogue
var current_dialogue = null            ## Current object of the active dialogue
var dialogues = {}                     ## Maps name of dialogues to their trees and roots
var symbols = {}                       ## List of symbols that exist in this context
var processing = false                 ## State of the context (a flag to show if we are currently processing a dialogue)
var wait_branch = false                ## State indicating that the context is waiting for a branch selection
var write_state = WriteState.WriteNone ## State indicating that the context is waiting for the player to progress write node
var error = null                       ## State of the context as an error (if one exists we cannot progress)
var test_mode = false                  ## Special flag for testing
var parser = null

signal on_context_begin   ## Called when the context has begun or has been reset
signal on_context_process ## Called each time the context progresses its state through the graph to a new node
signal on_context_finish  ## Called when the end of the current dialogue graph is reached
signal on_context_trigger ## Called when a trigger has been executed in the script

func _ready():
	parser = DialogueParser.new()
	if dialogue_file_names != null:
		for index in dialogue_file_names.size(): 
			self.add_dialogue_file(dialogue_file_names[index], dialogue_file_locations[index])

func _process(delta):
	if processing:
		evaluate_current_node()
	
	var camera = get_node('/root/game_manager').current_camera
	if (camera != null):
		var cam_pos = camera.get_camera_position()
		var size = get_viewport().size
		self.rect_position = Vector2(cam_pos.x - (size.x / 2), cam_pos.y + (size.y / 2))

## Parses the given dialogue file and adds it to the context for use in the Dialogue System
func add_dialogue_file(dialogue_name, file_name):
	parser = DialogueParser.new()
	parser.parse(file_name)
	dialogues[dialogue_name] = parser.result_full

## Initiates the Dialogue Context with a new dialogue that has been stored
func start_dialogue(dialogue_name, process = true):
	if dialogues.has(dialogue_name):
		current_dialogue = dialogues[dialogue_name]
		current_node = current_dialogue['root']
		processing = process
		emit_signal('on_context_begin')
	else:
		error = 'Starting Dialogue Error: no dialogue stored with that name'

## Helper function to progress through the Dialogue Graph
func evaluate_current_node():
	if current_node == null || !processing || wait_branch:
		return
	
	match current_node.type:
		DialogueNode.NodeType.Write:
			if write_state == WriteState.WriteNone:
				write_state = WriteState.WriteProcess
				emit_signal('on_context_process', current_node)
			elif write_state == WriteState.WriteContinue:
				write_state = WriteState.WriteNone
				current_node = current_node.children[0]
		DialogueNode.NodeType.Branch:
			emit_signal('on_context_process', current_node)
			wait_branch = true
		DialogueNode.NodeType.Locate:
			var location = current_node.content.strip_edges()
			if location == 'end':
				self.conclude_dialogue()
			elif current_dialogue['pointers'].has(location):
				current_node = current_dialogue['pointers'][location]
				emit_signal('on_context_process', current_node)
			else:
				error = 'Context Location Error: could not locate node ' + location + ' in dialogue'
		DialogueNode.NodeType.Point:
			current_node = current_node.children[0]
		DialogueNode.NodeType.Trigger:
			emit_signal('on_context_trigger', current_node)
			current_node = current_node.children[0]
		DialogueNode.NodeType.Set:
			if current_node.metadata.size() > 0:
				symbols[current_node.metadata[0]] = true
			else:
				error = 'Context Setting Error: no symbol given to set node'
				
			current_node = current_node.children[0]
		DialogueNode.NodeType.Unset:
			if current_node.metadata.size() > 0:
				symbols[current_node.metadata[0]] = false
			else:
				error = 'Context Unsetting Error: no symbol given to unset node'
				
			current_node = current_node.children[0]
		DialogueNode.NodeType.Evaluate:
			if current_node.metadata.size() == 0:
				error = 'Context Evaluate Error: no symbol given to evaluate in node'
			
			if current_node.children.size() < 2:
				error = 'Context Evaluate Error: evaluate node must have two children'
			
			if symbols.has(current_node.metadata[0]) && symbols[current_node.metadata[0]]:
				current_node = current_node.children[0]
			else:
				current_node = current_node.children[1]
		DialogueNode.NodeType.Error:
			error = 'Context Node Error'
		_:
			error = 'Context Unknown Error'
	
	if current_node == null || current_node.children.size() == 0:
		self.conclude_dialogue()
		return
	

func finish_writing():
	write_state = WriteState.WriteContinue
	

## Selects the branch by index (int) and sets the current node to the selected branch
## -> note: must figure out the index outside of this method
func pick_branch(branch_choice):
	if current_node.type == DialogueNode.NodeType.Branch:
		current_node = current_node.children[branch_choice]
		wait_branch = false
	else:
		error = 'Branch Choice Error: current node is not a Branch Node'

## Finishes the dialogue, turning off processing state, reset current_node and current_dialogue
## also emitting a 'finish' signal
func conclude_dialogue():
	processing = false
	current_node = null
	current_dialogue = null
	emit_signal('on_context_finish')
	
## Evaluates symbol and returns true if it exists, false otherwise
func evaluate_symbol(symbol_name):
	if !symbols.has(symbol_name):
		return false
	
	return symbols[symbol_name]
	

## Helper function that can be called by the manager to save the state of the symbols
## that exist in this context
func save_symbols():
	var symbol_file = File.new()
	symbol_file.open('user://symbols.save', File.WRITE)
	symbol_file.store_line(to_json(symbols))
	symbol_file.close()
	

## Helper function to load any stored symbols between room loading
func load_symbols():
	var symbol_file = File.new()
	var symbol_json = null
	if not symbol_file.file_exists('user://symbols.save'):
		return 0
	
	symbol_file.open('user://symbols.save', File.READ)
	symbol_json = parse_json(symbol_file.get_line())
	symbols = symbol_json
	symbol_file.close()
	return symbol_json
	
