# Filename: dialogue_controller.gd
# Brief: Reacts to the DialogueContext to control the UI visuals
# Author: Jamie Massey
# Created: 21/02/2019
extends Container

var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')

var letters_per_sec = 0.05 ## How many letters to display per x seconds
var button_offset = 35       ## Pixel spacing of all buttons from bottom of screen
var button_spacing = 35      ## Pixel spacing between each button choice
var buttons = []                  ## Stored button objects
var context = null                ## Reference to the parent context of the controller
var controller_begin_tween = null ## Stores Tweener to slide whole dialogue controller in
var controller_end_tween = null   ## Stores Tweener to fade dialogue controller out when finished
var buttons_unpack_tween = null   ## Stores Tweener to slide buttons onto screen
var buttons_pack_tween = null     ## Stores Tweener to drop buttons off of screen
var text_timer = null             ## Timer to track intervals to add text
var text_target = ''              ## Stores the target string and prints out to it (if non-empty) 
var readout_sound_files = []      ## Array of sounds that can be played
var readout_sounds = []           ## Array of AudioPlayerStream objects
var readout_sounds_buffer = []    ## Buffering array that stops sound popping on dialogue
var readout_sounds_switch = true  ## Buffering switch that flicks between source and buffer sound

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
	text_timer.wait_time = letters_per_sec
	text_timer.connect('timeout', self, '_text_timer_tick')
	readout_sound_files.append('res://resources/sfx/dialogue/beep.wav')
	self.add_child(buttons_unpack_tween)
	self.add_child(buttons_pack_tween)
	self.add_child(controller_begin_tween)
	self.add_child(controller_end_tween)
	self.add_child(text_timer)
	get_tree().get_root().connect('size_changed', self, '_on_resize')
	
	for i in range(readout_sound_files.size()):
		readout_sounds.append(AudioStreamPlayer.new())
		readout_sounds[i].stream = load(readout_sound_files[i])
		readout_sounds[i].stream.loop_mode = AudioStreamSample.LOOP_DISABLED
		readout_sounds_buffer.append(AudioStreamPlayer.new())
		readout_sounds_buffer[i].stream = load(readout_sound_files[i])
		readout_sounds_buffer[i].stream.loop_mode = AudioStreamSample.LOOP_DISABLED
		self.add_child(readout_sounds[i])
		self.add_child(readout_sounds_buffer[i])
	    

## Signal that is emitted when context starts new dialogue
func _react_context_begin():
	self.rect_global_position.y = 240
	self.show()
	var calc_before_y = get_viewport().size.y + rect_size.y
	var calc_after_y = get_viewport().size.y - rect_size.y
	controller_begin_tween.interpolate_property(self, 'rect_global_position:y', calc_before_y, calc_after_y, 0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	controller_begin_tween.interpolate_property(self, 'modulate:a', 0, 1, 0.35, Tween.TRANS_LINEAR, Tween.EASE_IN)
	controller_begin_tween.start()
	

## Signal that is emitted when context finishes its current dialogue
func _react_context_finished():
	controller_end_tween.interpolate_property(self, 'modulate:a', 1, 0, 0.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	controller_end_tween.start()
	$DialogueText.text = text_target
	

## Signal that is emitted when context is modified
func _react_context_process(node):
	if node.type == DialogueNode.NodeType.Write:
		$DialogueText.text = ''
		text_target = node.content
	elif node.type == DialogueNode.NodeType.Branch:
		$DialogueText.text = text_target
		expand_button_count(node.metadata)
		unpack_buttons()
	

## Signal that comes from Godot itself allowing us to deal with the size of the viewport
## changing. Here we re-position buttons and the UI itself depending on context state.
func _on_resize():
	var size = get_viewport().size
	if context && context.processing:
		self.rect_global_position.y = size.y - self.rect_size.y
		
		if context.wait_branch:
			for i in range(buttons.size()):
				buttons[i].rect_global_position.y = size.y - (button_offset + (button_spacing * i))
	else:
		self.rect_global_position.y = size.y + self.rect_size.y
		for i in range(buttons.size()):
			buttons[i].rect_global_position.x = size.x
			buttons[i].rect_global_position.y = size.y - (button_offset + (button_spacing * i))
	

## Signal for interval timer to progress text reader
func _text_timer_tick():
	if (text_target != '' && $DialogueText.text.length() < text_target.length()):
		$DialogueText.text = $DialogueText.text + text_target[$DialogueText.text.length()]
		var sound = randi() % readout_sounds.size()
		if readout_sounds_switch:
			readout_sounds[sound].play()
			readout_sounds_switch = false
		else:
			readout_sounds_buffer[sound].play()
			readout_sounds_switch = true
	

## Signal called when the controller is finished
func _controller_end_tween_finished(obj, key):
	self.hide()
	

## Signal called when choice has been selected and tweening is finished,
## here we reset all the button variables
func _buttons_pack_tween_finished(obj, key):
	var size = get_viewport().size
	for i in range(buttons.size()):
		buttons[i].rect_global_position = Vector2(size.x, size.y - (button_offset + (button_spacing * i)))
		buttons[i].disabled = true
		buttons[i].modulate.a = 1
		buttons[i].hide()

## Signal called when a choice button is pressed, we update the context and tell it
## which branch to progress on
func _on_choice_pressed(button):
	var index = buttons.find(button)
	context.pick_branch(index)
	pack_buttons()

## Helper function that unpacks the buttons on the screen, setting up all the buttons for
## tweening, and then kickstarting the tweener
func unpack_buttons():
	var viewport_x = get_viewport().size.x
	for button in range(buttons.size()):
		var calc_before_x = viewport_x + (buttons[button].rect_size.x + 10)
		var calc_after_x = viewport_x - (buttons[button].rect_size.x + 10)
		buttons_unpack_tween.interpolate_property(buttons[button], 'rect_global_position:x', calc_before_x, calc_after_x, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.05 * button)
		buttons[button].show()
		buttons[button].disabled = false
	
	buttons_unpack_tween.start()
	

## Helper function that packs the buttons away from the screen
func pack_buttons():
	var viewport_y = get_viewport().size.y
	for button in buttons:
		buttons_pack_tween.interpolate_property(button, 'rect_global_position:y', button.rect_global_position.y, viewport_y + button.rect_size.y, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		buttons_pack_tween.interpolate_property(button, 'modulate:a', 1, 0, 0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		
	buttons_pack_tween.start()
	

## Helper function that creates any new required buttons and sets up old buttons with the correct
## metadata and positioning
func expand_button_count(metadata):
	var num = max(0, metadata.size() - buttons.size())
	for i in num:
		var button = Button.new()
		button.rect_min_size = Vector2(150, 25)
		button.connect("pressed", self, "_on_choice_pressed", [button])
		button.add_font_override("font", load('res://resources/fonts/dynamic_font_btn.tres'))
		buttons.append(button)
		self.add_child(button)
		
	for i in range(buttons.size()):
		var size = get_viewport().size
		buttons[i].rect_global_position = Vector2(size.x, size.y - (button_offset + (button_spacing * i)))
		buttons[i].rect_min_size = Vector2(150, 25)
		buttons[i].set_text(metadata[i])
		buttons[i].rect_size = Vector2(150, 25)
		buttons[i].disabled = true
	