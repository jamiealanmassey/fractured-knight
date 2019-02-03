extends 'res://addons/gut/test.gd'

class TestDialogueParser:
	extends 'res://addons/gut/test.gd'
	
	var Parser = load('res://resources/dialogue_system/dialogue_parser.gd')
	var parser = null
	var results = null
	
	func before_all():
		parser = Parser.new()
		parser.parse('res://test/dialogue/default.fml')
		
	func test_basic_dialogue():
		assert_eq(parser.result[0], 'write Hello there fellow adventurer!', 'line 0 does not match')
		assert_eq(parser.result[1], 'write Beware for these paths are treacherous!', 'line 1 does not match')
	
	func test_root_exists():
		assert_ne(parser.root, null, 'root node is missing')
	
	func test_basic_dialogue_tree():
		var node = parser.root
		assert_eq(node.metadata[0], 'write Hello there fellow adventurer!', 'line 0 does not match')
		node = parser.root.children[0]
		assert_eq(node.metadata[0], 'write Hello there fellow adventurer!', 'line 0 does not match')
