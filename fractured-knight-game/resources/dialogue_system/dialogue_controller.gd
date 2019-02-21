# Filename: dialogue_controller.gd
# Brief: Reacts to the DialogueContext to control the UI visuals
# Author: Jamie Massey
# Created: 21/02/2019
extends Container

var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')

func _react_context_begin():
	self.show()
	print('Controller has reacted to context begin')

func _react_context_finished():
	self.hide()
	print('Controller has reacted to context finished')

func _react_context_process(node):
	if node.type == DialogueNode.NodeType.Write:
		$DialogueText.set_text(node.content)
	
	print('Controller has reacted to context process')
