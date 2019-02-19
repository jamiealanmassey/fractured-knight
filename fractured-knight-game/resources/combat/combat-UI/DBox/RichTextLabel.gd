extends RichTextLabel

onready var Timer = get_node("../Timer")

onready var stringPrinted = "This is a test"

func _ready():
    Timer.set_wait_time(.1) # time between letters

func set_string( string ):
    for letter in string:
        Timer.start()
        self.add_text( letter )
        yield(Timer, "timeout")
