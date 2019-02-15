extends 'res://addons/gut/test.gd'

class TestDialogueContext:
	extends 'res://addons/gut/test.gd'
	
	var DialogueSystem = load('res://resources/dialogue_system/dialogue_system.tscn')
	var DialogueContext = load('res://resources/dialogue_system/dialogue_context.gd')
	var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')
	var system = null
	
	func before_each():
		system = DialogueSystem.instance()
		system.add_dialogue_file('test', 'res://test/dialogue/complex.fml')
		
	func test_context_loads():
		assert_true(system.dialogues.has('test'))
		assert_ne(system.dialogues['test']['root'], null)
		assert_gt(system.dialogues['test']['pointers'].size(), 0)
	
	func test_context_starts():
		system.start_dialogue('test')
		assert_true(system.processing)
		assert_eq(system.current_dialogue, system.dialogues['test'])
		assert_eq(system.current_node, system.dialogues['test']['root'])
		while system.current_node != null:
			if system.current_node.type == DialogueNode.NodeType.Branch:
				system.pick_branch(1)
			
			system.evaluate_current_node()
		
		assert_eq(system.error, null)
		#assert_signal_emitted(system, 'on_context_change')
		#assert_signal_emit_count(system, 'on_context_change', 5)
	