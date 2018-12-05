extends CanvasLayer

signal option_1_chosen
signal option_2_chosen
signal option_3_chosen
signal option_4_chosen


# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func set_text(text):
	$Panel/VBoxContainer/ConversationText.text = text
	pass

func clear_text():
	$Panel/VBoxContainer/ConversationText.text = ""

#sets health as percentage
func set_heatlh(health):
	#Update damage bar here
	$Panel/VBoxContainer/HealthBar.rect_size.x = health
	#adjust health bar width based on the amount of damage taken
	pass

#Changes button texts to show combat options
func change_to_combat():
	$Panel/VBoxContainer/Buttons/Button1.text = "Attack"
	$Panel/VBoxContainer/Buttons/Button2.text = "Talk"
	$Panel/VBoxContainer/Buttons/Button3.hide()
	$Panel/VBoxContainer/Buttons/Button4.text = "Flee"

#Changes button texts to chat options
func change_to_talking():
	$Panel/VBoxContainer/Buttons/Button3.show()
	$Panel/VBoxContainer/Buttons/Button1.text = "Option 1"
	$Panel/VBoxContainer/Buttons/Button2.text = "Option 2"
	$Panel/VBoxContainer/Buttons/Button3.text = "Option 3"
	$Panel/VBoxContainer/Buttons/Button4.text = "Option 4"	

func set_button_label(index, label):
	if (index == 0):
		$Panel/VBoxContainer/Buttons/Button1.text = label
	elif (index == 1):
		$Panel/VBoxContainer/Buttons/Button2.text = label
	elif (index == 2):
		$Panel/VBoxContainer/Buttons/Button3.text = label
	elif (index == 3):
		$Panel/VBoxContainer/Buttons/Button4.text = label

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button1_pressed():
	emit_signal("option_1_chosen", self)


func _on_Button2_pressed():
	emit_signal("option_2_chosen", self)


func _on_Button3_pressed():
	emit_signal("option_3_chosen", self)


func _on_Button4_pressed():
	emit_signal("option_3_chosen", self)
