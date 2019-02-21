extends RichTextLabel

signal finished_displaying_text

onready var Timer = get_node("../Timer")


func _ready():
    Timer.set_wait_time(.1) # time between letters

func set_string( string ):
	for letter in string:
		Timer.start()
		self.add_text( letter )
		yield(Timer, "timeout")
	self.add_text("\n")
	emit_signal("finished_displaying_text")
