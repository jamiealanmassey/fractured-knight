extends RichTextLabel

var string

func _ready():
	pass
 

func set_string(string):
	for i in range(0, 200):
		if(i < 150):
			add_text(string)
		else:
			add_text(" ")
