extends "res://addons/gut/test.gd"

class TestCreationNode:
	extends "res://addons/gut/test.gd"
	
	var obj = load('res://resources/combat/combat-UI/UIBox.gd')
	
	func test_nodeLabalCreaton():
		obj = obj.new()
		array = ["1", "2"]
		