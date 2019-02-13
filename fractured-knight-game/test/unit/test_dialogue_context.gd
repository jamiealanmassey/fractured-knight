extends 'res://addons/gut/test.gd'

class TestDialogueContext:
	extends 'res://addons/gut/test.gd'
	
	var DialogueSystem = load('res://resources/dialogue_system/dialogue_system.tscn')
	var DialogueContext = load('res://resources/dialogue_system/dialogue_context.gd')
	var DialogueNode = load('res://resources/dialogue_system/dialogue_node.gd')
	var system = null
	
	func before_all():
		system = DialogueSystem.instance()
		
	func test_context_loads():
		system.add_dialogue_file('test', 'res://test/dialogue/complex.fml')
		assert_true(system.dialogues.has('test'))
		assert_ne(system.dialogues['test']['root'], null)
		assert_gt(system.dialogues['test']['pointers'].size(), 0)
	
	func test_context_starts():
		system.start_dialogue('test')
		assert_true(system.processing)
		assert_eq(system.current_dialogue, system.dialogues['test'])
		assert_eq(system.current_node, system.dialogues['test']['root'])
	