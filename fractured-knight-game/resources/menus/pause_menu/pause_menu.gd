extends Control

var active = false

signal resume_game

func _process(delta):
	if active:
		var camera_pos = get_node('/root/game_manager').current_camera.get_camera_position()
		var size = get_viewport().size
		self.rect_position = Vector2(camera_pos.x - size.x / 2, camera_pos.y - size.y / 2)
		
		if Input.is_action_pressed('ui_cancel') && is_ready():
			emit_signal('resume_game')
			$BiasTimer.start()
	

func kickstart():
	$BiasTimer.start()
	

func is_ready():
	return ($BiasTimer.time_left <= 0)

func _on_ResumeBtn_pressed():
	emit_signal('resume_game')
	$BiasTimer.start()
	

func _on_SettingsBtn_pressed():
	pass # TODO: open settings menu
	

func _on_QuitBtn_pressed():
	get_tree().quit()
	
