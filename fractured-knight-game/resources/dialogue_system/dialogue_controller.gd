# Filename: dialogue_controller.gd
# Brief: Reacts to the DialogueContext to control the UI visuals
# Author: Jamie Massey
# Created: 21/02/2019
extends Container

var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')

export (float) var unpack_factor = 1

var buttons = []                  ## Stored button objects
var context = null                ## Reference to the parent context of the controller
var controller_begin_tween = null ## Stores Tweener to slide whole dialogue controller in
var controller_end_tween = null   ## Stores Tweener to fade dialogue controller out when finished
var buttons_unpack_tween = null   ## Stores Tweener to slide buttons onto screen
var buttons_pack_tween = null     ## Stores Tweener to drop buttons off of screen
var text_timer = null             ## Timer to track intervals to add text
var text_target = ''              ## Stores the target string and prints out to it (if non-empty)

func _ready():
	context = get_parent()
	buttons_unpack_tween = Tween.new()
	buttons_pack_tween = Tween.new()
	buttons_pack_tween.connect('tween_completed', self, '_buttons_pack_tween_finished')
	controller_begin_tween = Tween.new()
	controller_end_tween = Tween.new()
	controller_end_tween.connect('tween_completed', self, '_controller_end_tween_finished')
	text_timer = Timer.new()
	text_timer.autostart = true
	text_timer.wait_time = 0.075
	text_timer.connect('timeout', self, '_text_timer_tick')
	self.add_child(buttons_unpack_tween)
	self.add_child(buttons_pack_tween)
	self.add_child(controller_begin_tween)
	self.add_child(controller_end_tween)
	self.add_child(text_timer)
	print(context)

func _react_context_begin():
	self.rect_global_position.y = 240
	self.show()
	controller_begin_tween.interpolate_property(self, 'rect_global_position', Vector2(0, 240), Vector2(0, 0), 0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	controller_begin_tween.interpolate_property(self, 'modulate:a', 0, 1, 0.35, Tween.TRANS_LINEAR, Tween.EASE_IN)
	controller_begin_tween.start()
	print('Controller has reacted to context begin')

func _react_context_finished():
	controller_end_tween.interpolate_property(self, 'modulate:a', 1, 0, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	controller_end_tween.start()
	print('Controller has reacted to context finished')

func _react_context_process(node):
	if node.type == DialogueNode.NodeType.Write:
		$DialogueText.text = ''
		text_target = node.content
	elif node.type == DialogueNode.NodeType.Branch:
		expand_button_count(node.metadata)
		unpack_buttons()
	
	print('Controller has reacted to context process')

func _text_timer_tick():
	if (text_target != '' && $DialogueText.text.length() < text_target.length()):
		$DialogueText.text = $DialogueText.text + text_target[$DialogueText.text.length()]

func _controller_end_tween_finished(obj, key):
	self.hide()
	print('tween end finished')

func _buttons_pack_tween_finished(obj, key):
	for button in buttons:
		button.disabled = true
		button.modulate.a = 1
		#button.rect_rotation = 0
		button.hide()

func _on_choice_pressed(button):
	var index = buttons.find(button)
	context.pick_branch(index)
	#hide_all_buttons()
	pack_buttons()

func unpack_buttons():
	var viewport_x = get_viewport().size.x
	for button in range(buttons.size()):
		var calc_before_x = viewport_x + (buttons[button].rect_size.x + 10)
		var calc_after_x = viewport_x - (buttons[button].rect_size.x + 10)
		buttons_unpack_tween.interpolate_property(buttons[button], 'rect_global_position:x', calc_before_x, calc_after_x, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.05 * button)
		buttons[button].show()
		buttons[button].disabled = false
	
	buttons_unpack_tween.start()

func pack_buttons():
	var viewport_y = get_viewport().size.y
	for button in buttons:
		#buttons_pack_tween.interpolate_property(button, 'rect_rotation', 0, 90, 0.25,  Tween.TRANS_LINEAR, Tween.EASE_OUT)
		buttons_pack_tween.interpolate_property(button, 'rect_global_position:y', button.rect_global_position.y, viewport_y + button.rect_size.y, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		buttons_pack_tween.interpolate_property(button, 'modulate:a', 1, 0, 0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		
	buttons_pack_tween.start()

func hide_all_buttons():
	for i in range(buttons.size()):
		buttons[i].hide()

func expand_button_count(metadata):
	var num = max(0, metadata.size() - buttons.size())
	for i in num:
		var button = Button.new()
		button.rect_min_size = Vector2(120, 25)
		button.connect("pressed", self, "_on_choice_pressed", [button])
		button.add_font_override("font", load('res://resources/fonts/dynamic_font_btn.tres'))
		buttons.append(button)
		self.add_child(button)
		
	for i in range(buttons.size()):		
		buttons[i].set_anchor_and_margin(MARGIN_BOTTOM, 1, 0)
		buttons[i].set_anchor_and_margin(MARGIN_RIGHT, 1, 0)
		buttons[i].set_anchor_and_margin(MARGIN_TOP, 1, -(100 + (38 * i)))
		buttons[i].set_anchor_and_margin(MARGIN_LEFT, 1, 0)
		buttons[i].rect_min_size = Vector2(150, 25)
		buttons[i].set_text(metadata[i])
		buttons[i].rect_size = Vector2(150, 25)
		buttons[i].disabled = true
		
	