extends 'res://addons/gut/test.gd'

class TestDialogueParser:
	extends 'res://addons/gut/test.gd'
	
	var Player = load('res://resources/player/player.tscn')
	var player = null
	
	func before_each():
		player = Player.instance()
		self.add_child(player)
		
	func after_each():
		player.queue_free()
		
	func test_stored_keystates():
		assert_eq(player.key_states.size(), 4, 'too many keystates')
		
		assert_eq(player.key_states[0].state, false, 'keystate left should be set to false')
		assert_eq(player.key_states[1].state, false, 'keystate right should be set to false')
		assert_eq(player.key_states[2].state, false, 'keystate up should be set to false')
		assert_eq(player.key_states[3].state, false, 'keystate down should be set to false')
		
		assert_eq(player.key_states[0].name, 'left', 'keystate left has incorrect name')
		assert_eq(player.key_states[1].name, 'right', 'keystate right has incorrect name')
		assert_eq(player.key_states[2].name, 'up', 'keystate up has incorrect name')
		assert_eq(player.key_states[3].name, 'down', 'keystate down has incorrect name')
	
		assert_eq(player.key_states[0].stamp, 0, 'keystate left has incorrect starting timestamp')
		assert_eq(player.key_states[1].stamp, 0, 'keystate right has incorrect starting timestamp')
		assert_eq(player.key_states[2].stamp, 0, 'keystate up has incorrect starting timestamp')
		assert_eq(player.key_states[3].stamp, 0, 'keystate down has incorrect starting timestamp')
	
	func test_keystate_time_sorted():
		player.key_states[0].stamp = 4000
		player.key_states[1].stamp = 2000
		player.key_states[2].stamp = 4500
		player.key_states[3].stamp = 3050
		player.key_states.sort_custom(player.KeyStateSorter, 'sort')
		
		assert_eq(player.key_states[0].name, 'right', 'first element should now be right')
		assert_eq(player.key_states[1].name, 'down', 'second element should now be down')
		assert_eq(player.key_states[2].name, 'left', 'third element should now be left')
		assert_eq(player.key_states[3].name, 'up', 'fourth element should now be up')
		
	func test_loading_player():
		player.combat_actor = load("res://test/unit/example_actor.tres")
		var actor = player.combat_actor
		assert_ne(actor, null, "Actor should not be null")
		var health = actor.health
		var moves = actor.get_all_moves()
		var accuracy = actor.get_stat('accuracy')
		var damage = actor.get_stat('damage')
		
		assert_eq(health, 50, "Health should be 50")
		assert_eq(accuracy, 10, "Accuracy should be 10")
		assert_eq(damage, 2, "Damage should be 2")
		
		assert_eq(moves[0].move_name, "punch", "Move name should be punch")
		
		
		pass
	

