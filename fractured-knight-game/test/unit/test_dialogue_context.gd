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
		system.test_mode = true
		assert_true(system.processing)
		assert_eq(system.current_dialogue, system.dialogues['test'])
		assert_eq(system.current_node, system.dialogues['test']['root'])
		while system.current_node != null:
			if system.current_node.type == DialogueNode.NodeType.Branch:
				system.pick_branch(1)
			elif system.current_node.type == DialogueNode.NodeType.Write:
				system.write_state = DialogueContext.WriteState.WriteContinue
			
			system.evaluate_current_node()
		
		assert_eq(system.error, null)
		#assert_signal_emitted(system, 'on_context_change')
		#assert_signal_emit_count(system, 'on_context_change', 5)
	
	func test_context_persistence():
		var persistence_obj = null
		system.symbols['found_sword'] = true
		system.symbols['interact_with_knight'] = true
		system.save_symbols()
		system.symbols.clear()
		persistence_obj = system.load_symbols()
		
		# Test results data structure
		assert_true(persistence_obj.has('found_sword'), 'no entry with name found_sword in symbols dict')
		assert_true(persistence_obj.has('interact_with_knight'), 'no entry with name interact_with_knight in symbols dict')
		assert_eq(persistence_obj['found_sword'], true, 'found_sword entry is not true and should be')
		assert_eq(persistence_obj['interact_with_knight'], true, 'found_sword entry is not true and should be')
		assert_eq(persistence_obj.size(), 2, 'more than two entries was unexpected')
		
		# Test internal data structure
		assert_true(system.symbols.has('found_sword'), 'no entry with name found_sword in symbols dict')
		assert_true(system.symbols.has('interact_with_knight'), 'no entry with name interact_with_knight in symbols dict')
		assert_eq(system.symbols['found_sword'], true, 'found_sword entry is not true and should be')
		assert_eq(system.symbols['interact_with_knight'], true, 'found_sword entry is not true and should be')
		assert_eq(system.symbols.size(), 2, 'more than two entries was unexpected')
	
