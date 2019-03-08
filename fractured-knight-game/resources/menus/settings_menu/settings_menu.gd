extends Control

func _ready():
	$VBoxContainer/ResolutionOptions.add_item('3840x2160')
	$VBoxContainer/ResolutionOptions.add_item('2560x1440')
	$VBoxContainer/ResolutionOptions.add_item('2048x1080')
	$VBoxContainer/ResolutionOptions.add_item('1920x1080')
	$VBoxContainer/ResolutionOptions.add_item('1680x1050')
	$VBoxContainer/ResolutionOptions.add_item('1360x768')
	$VBoxContainer/ResolutionOptions.add_item('1366x768')
	$VBoxContainer/ResolutionOptions.add_item('1280x768')
	$VBoxContainer/ResolutionOptions.add_item('1280x720')
	$VBoxContainer/ResolutionOptions.add_item('1024x768')
	$VBoxContainer/ResolutionOptions.add_item('800x600')
	$VBoxContainer/ResolutionOptions.add_item('640x480')
	$VBoxContainer/ResolutionOptions.add_item('640x400')
