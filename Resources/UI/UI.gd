extends CanvasLayer

signal option_1_chosen
signal option_2_chosen
signal option_3_chosen
signal option_4_chosen

var health_size

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	health_size = $Panel/VBoxContainer/HealthBar.rect_size.x
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func set_text(text):
	$Panel/VBoxContainer/ConversationText.text = text
	pass

func clear_text():
	$Panel/VBoxContainer/ConversationText.text = ""

#sets health as percentage
func set_health(health):
	#Update damage bar here
	print(health)
	$Panel/VBoxContainer/HealthBar.rect_size.x = health_size * (health/100.0)
	#adjust health bar width based on the amount of damage taken
	pass

#Changes button texts to show combat options
func change_to_combat():
	$Panel/VBoxContainer/Buttons/Button1.show()
	$Panel/VBoxContainer/Buttons/Button1.text = "Attack"
	$Panel/VBoxContainer/Buttons/Button2.show()
	$Panel/VBoxContainer/Buttons/Button2.text = "Talk"
	$Panel/VBoxContainer/Buttons/Button3.show()
	$Panel/VBoxContainer/Buttons/Button3.text = "Flee"
	$Panel/VBoxContainer/Buttons/Button4.hide()

#Changes button texts to chat options
func change_to_talking():
	$Panel/VBoxContainer/Buttons/Button3.show()
	$Panel/VBoxContainer/Buttons/Button1.text = "Option 1"
	$Panel/VBoxContainer/Buttons/Button2.text = "Option 2"
	$Panel/VBoxContainer/Buttons/Button3.text = "Option 3"
	$Panel/VBoxContainer/Buttons/Button4.text = "Option 4"	

func change_to_fighting():
	$Panel/VBoxContainer/Buttons/Button1.show()
	$Panel/VBoxContainer/Buttons/Button1.text = "Attack"
	$Panel/VBoxContainer/Buttons/Button2.show()
	$Panel/VBoxContainer/Buttons/Button2.text = "Defend"
	$Panel/VBoxContainer/Buttons/Button3.show()
	$Panel/VBoxContainer/Buttons/Button3.text = "Dodge"
	$Panel/VBoxContainer/Buttons/Button4.hide()

func set_button_label(index, label):
	if (index == 0):
		$Panel/VBoxContainer/Buttons/Button1.text = label
	elif (index == 1):
		$Panel/VBoxContainer/Buttons/Button2.text = label
	elif (index == 2):
		$Panel/VBoxContainer/Buttons/Button3.text = label
	elif (index == 3):
		$Panel/VBoxContainer/Buttons/Button4.text = label

func set_button_visibility(index, flag):
	if (index == 0):
		$Panel/VBoxContainer/Buttons/Button1.visible = flag
	elif (index == 1):
		$Panel/VBoxContainer/Buttons/Button2.visible = flag
	elif (index == 2):
		$Panel/VBoxContainer/Buttons/Button3.visible = flag
	elif (index == 3):
		$Panel/VBoxContainer/Buttons/Button4.visible = flag

func _on_Button1_pressed():
	emit_signal("option_1_chosen")


func _on_Button2_pressed():
	emit_signal("option_2_chosen")


func _on_Button3_pressed():
	emit_signal("option_3_chosen")


func _on_Button4_pressed():
	emit_signal("option_4_chosen")
