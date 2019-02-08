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
		assert_eq(node.content, 'Good day traveler.', 'line 1 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		assert_eq(node.children.size(),1, 'node does not have one child' )
		node = node.children[0]
		assert_eq(node.content, 'You must watch yourself in these parts.', 'line 2 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		node = node.children[0]
		assert_eq(node.metadata[0], 'I heed your advice', 'first metadata of branch does not match')
		assert_eq(node.metadata[1], 'You don\'t scare me!', 'second metadata of branch does not match')
		assert_eq(node.type, DialogueNode.NodeType.Branch, 'node should be of type branch')
		assert_eq(node.children.size(),2, 'node does not have two children')
		var node2 = node 
		node = node.children[0]
		assert_eq(node.metadata[0], 'heeded', 'metadata of point does not match')
		assert_eq(node.type, DialogueNode.NodeType.Point, 'node should be of type point')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.content, 'Good! You would be wise to do so.', 'line 5 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.content, 'Go forth and tread carefully.', 'line 6 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.metadata[0], 'door_blocked', 'metadata does not match')
		assert_eq(node.type, DialogueNode.NodeType.Unset, 'node should be of type unset')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.metadata[0], 'unlock_door', 'metadata does not match')
		assert_eq(node.type, DialogueNode.NodeType.Trigger, 'node should be of type trigger')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node2.children[1]
		assert_eq(node.metadata[0], 'scare', 'metadata of point does not match')
		assert_eq(node.type, DialogueNode.NodeType.Point, 'node should be of type point')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.content, 'It is foolish of you to ignore my warning!', 'line 11 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.content, 'Turn back now, you are not prepared for this journey.', 'line 11 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.metadata[0], 'door_blocked', 'metadata does not match')
		assert_eq(node.type, DialogueNode.NodeType.Set, 'node should be of type set')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.metadata[0], 'block_door', 'metadata does not match')
		assert_eq(node.type, DialogueNode.NodeType.Trigger, 'node should be of type trigger')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.metadata[0], 'door_blocked', 'metadata does not match')
		assert_eq(node.type, DialogueNode.NodeType.Evaluate, 'node should be of type evaluate')
		assert_eq(node.children.size(),2, 'node does not have 2 children')
		node2 = node
		node = node.children[0]
		assert_eq(node.content, 'You hear a click and a sinking feeling floods you', 'line 17 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.content, 'end', 'line 18 does not match')
		assert_eq(node.type, DialogueNode.NodeType.Locate, 'node should be of type locate')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node2.children[1]
		assert_eq(node.content, 'Farewell traveller, until next time!')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'line 20 does not match')
		assert_eq(node.children.size(),1, 'node does not have one child')
		node = node.children[0]
		assert_eq(node.content, 'Oh, and one last piece of advice, it\'s dangerous to go alone.')
		assert_eq(node.type, DialogueNode.NodeType.Write, 'node should be of type write')
		assert_eq(node.children.size(),0, 'node does not have no children')
		
	func print_nodes(node_list):
		for index in range(0, node_list.size()):
			print_node(index, node_list[index])
	
	func print_node(index, node):
		gut.p('Dialogue Node ' + str(index) + ' ' + str(node))
		gut.p('     type is ' + node_types[node.type])
		gut.p('     content is \"' + node.content + '\"')
		gut.p('     metadata is ' + str(node.metadata))
		gut.p('     children are ' + str(node.children))
