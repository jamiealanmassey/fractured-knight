# Filename: dialogue_controller.gd
# Brief: Reacts to the DialogueContext to control the UI visuals
# Author: Jamie Massey
# Created: 21/02/2019
extends Container

func _react_context_begin():
	print('Controller has reacted to context begin')

func _react_context_finished():
	print('Controller has reacted to context finished')

func _react_context_process():
	print('Controller has reacted to context process')
