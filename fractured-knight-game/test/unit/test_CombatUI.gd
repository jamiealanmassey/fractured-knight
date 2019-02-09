extends "res://addons/gut/test.gd"

class TestCreationNode:
	extends "res://addons/gut/test.gd"
	
	var obj = load('res://resources/combat/combat-UI/UIBox.gd')
	var _obj = null
	
	func before_each():
		_obj = obj.new()
	
	func test_nodeLabalCreaton():
		pending('this test is pending')