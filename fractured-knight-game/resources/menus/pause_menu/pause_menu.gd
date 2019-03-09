extends Control

var active = false

signal resume_game

func _process(delta):
	if active:
		var camera_pos = get_node('/root/game_manager').current_camera.get_camera_position()
		var size = get_viewport().size
		var new_pos = Vector2(camera_pos.x - size.x / 2, camera_pos.y - size.y / 2)
		self.rect_position = new_pos
		
		if Input.is_action_pressed('ui_cancel') && is_ready() && $SettingsMenu.visible:
			$VBoxContainer.visible = true
			$SettingsMenu.visible = false
			$BiasTimer.start()
			# TODO save settings
		elif Input.is_action_pressed('ui_cancel') && is_ready():
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
	$VBoxContainer.visible = false
	$SettingsMenu.visible = true
	

func _on_QuitBtn_pressed():
	get_tree().quit()
	
