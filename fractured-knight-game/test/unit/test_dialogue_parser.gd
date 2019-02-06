extends 'res://addons/gut/test.gd'

class TestDialogueParser:
	extends 'res://addons/gut/test.gd'
	
	var Parser = load('res://resources/dialogue_system/dialogue_parser.gd')
	var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')
	var parser = null
	var node_types = {}
	
	func before_all():
		node_types[DialogueNode.NodeType.Error]    = 'ERROR'
		node_types[DialogueNode.NodeType.Write]    = 'WRITE'
		node_types[DialogueNode.NodeType.Branch]   = 'BRANCH'
		node_types[DialogueNode.NodeType.Locate]   = 'LOCATE'
		node_types[DialogueNode.NodeType.Point]    = 'POINT'
		node_types[DialogueNode.NodeType.Trigger]  = 'TRIGGER'
		node_types[DialogueNode.NodeType.Set]      = 'SET'
		node_types[DialogueNode.NodeType.Unset]    = 'UNSET'
		node_types[DialogueNode.NodeType.Evaluate] = 'EVALUATE'
	
	func test_basic_dialogue():
		parser = Parser.new()
		parser.parse('res://test/dialogue/default.fml')
		assert_eq(parser.result[0], 'write Hello there fellow adventurer!', 'line 0 does not match')
		assert_eq(parser.result[1], 'write Beware for these paths are treacherous!', 'line 1 does not match')
	
	func test_root_exists():
		parser = Parser.new()
		parser.parse('res://test/dialogue/default.fml')
		assert_ne(parser.root, null, 'root node is missing')
	
	func test_basic_dialogue_tree():
		parser = Parser.new()
		parser.parse('res://test/dialogue/default.fml')
		var node = parser.root
		assert_eq(node.content, 'Hello there fellow adventurer!', 'line 0 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		node = node.children[0]
		assert_eq(node.content, 'Beware for these paths are treacherous!', 'line 0 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
	
	func test_complex_dialogue_tree():
		parser = Parser.new()
		parser.parse('res://test/dialogue/complex.fml')
		print_nodes(parser.result_nodes)
		
		var node = parser.root
		
	
	func print_nodes(node_list):
		for index in range(0, node_list.size()):
			print_node(index, node_list[index])
	
	func print_node(index, node):
		gut.p('Dialogue Node ' + str(index) + ' ' + str(node))
		gut.p('     type is ' + node_types[node.type])
		gut.p('     content is \"' + node.content + '\"')
		gut.p('     metadata is ' + str(node.metadata))
		gut.p('     children are ' + str(node.children))
