# Filename: dialogue_controller.gd
# Brief: Reacts to the DialogueContext to control the UI visuals
# Author: Jamie Massey
# Created: 21/02/2019
extends Container

var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')

var buttons = [] ## Stored button objects
var context = null 

func _ready():
	context = get_parent()
	print(context)

func _react_context_begin():
	self.show()
	print('Controller has reacted to context begin')

func _react_context_finished():
	self.hide()
	print('Controller has reacted to context finished')

func _react_context_process(node):
	if node.type == DialogueNode.NodeType.Write:
		$DialogueText.set_text(node.content)
	elif node.type == DialogueNode.NodeType.Branch:
		expand_button_count(node.metadata)
	
	print('Controller has reacted to context process')

func _on_choice_pressed(button):
	var index = buttons.find(button)
	context.pick_branch(index)
	hide_all_buttons()

func hide_all_buttons():
	for i in range(buttons.size()):
		buttons[i].hide()

func expand_button_count(metadata):
	var num = max(0, metadata.size() - buttons.size())
	for i in num:
		var button = Button.new()
		button.rect_min_size = Vector2(120, 25)
		button.connect("pressed", self, "_on_choice_pressed", [button])
		buttons.append(button)
		self.add_child(button)
		
	for i in range(buttons.size()):
		buttons[i].set_anchor_and_margin(MARGIN_BOTTOM, 1, 0)
		buttons[i].set_anchor_and_margin(MARGIN_RIGHT, 1, 0)
		buttons[i].set_anchor_and_margin(MARGIN_TOP, 1, -(50 + (38 * i)))
		buttons[i].set_anchor_and_margin(MARGIN_LEFT, 1, -150)
		buttons[i].rect_size = Vector2(130, 25)
		buttons[i].set_text(metadata[i])
		#buttons[i].hide()