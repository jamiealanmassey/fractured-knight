# Filename: dialogue_controller.gd
# Brief: Reacts to the DialogueContext to control the UI visuals
# Author: Jamie Massey
# Created: 21/02/2019
extends Container

var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')

var buttons = [] ## Stored button objects

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
		expand_button_count(node.metadata.size())
	
	print('Controller has reacted to context process')

func expand_button_count(size):
	var num = max(0, size - buttons.size())
	for i in num:
		var button = Button.new()
		button.rect_min_size = Vector2(180, 25)
		buttons.append(button)
		self.add_child(button)
		
	for i in range(buttons.size()):
		buttons[i].set_anchor_and_margin(MARGIN_BOTTOM, 1, 0)
		buttons[i].set_anchor_and_margin(MARGIN_RIGHT, 1, 0)
		buttons[i].set_anchor_and_margin(MARGIN_TOP, 1, -(30 + (35 * i)))
		buttons[i].set_anchor_and_margin(MARGIN_LEFT, 1, -200)
		buttons[i].rect_size = Vector2(180, 25)
		buttons[i].set_text("button" + str(i))