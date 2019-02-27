extends RichTextLabel

signal finished_displaying_text

onready var timer = get_node("../Timer")


func _ready():
	print(timer)
	timer.set_wait_time(.1) # time between letters

func set_string( string ):
	for letter in string:
		timer.start()
		self.add_text( letter )
		yield(timer, "timeout")
	self.add_text("\n")
	emit_signal("finished_displaying_text")
