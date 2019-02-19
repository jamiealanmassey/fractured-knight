extends Node
#emitted when combat is complete
signal combat_finished
#emitted when initalised to signal that the UI needs to start in its initial state
signal UI_get_ready
#Emitted when the move choices need to be known, passes the moves as an array
signal show_fighting_options
#emitted when menu needs to show the starting menu choices, e.g. fight, flee, item etc.
signal show_menu_options
#emitted when no buttons need to be pressed
signal output_only
#emitted when the text passed as an argument needs to be displayed 
signal display_text

#Current state the combat system is in. 0= main menu, 1= waiting for move input
var state
#The moves the player can do
var player_moves
var player
var enemy
var combat_in_progress = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# test code here 
	var player = load("res://resources/combat/combat-core/actor.tscn").instance()
	player.init(50)
	var enemy = load("res://resources/combat/combat-core/actor.tscn").instance()
	enemy.init(20)
	
	var move_scene = load("res://resources/combat/combat-core/move.tscn")
	var weapon_scene = load("res://resources/combat/combat-core/weapon.tscn")
	
	var move = move_scene.instance()
	var move2 = move_scene.instance()
	var sword = weapon_scene.instance()
	
	move.init("punch", 60, 8)
	
	player.add_move(move)
	
	sword = weapon_scene.instance()
	sword.init({"accuracy" : 20, "damage" : 5})
	
	move2 = move_scene.instance()
	move2.init("stab", 50, 7, sword)
	
	sword.add_move(move2)
	
	player.add_weapon(sword)
	enemy.add_move(move)
	enemy.add_weapon(sword)
	
	player.set_stat("damage", 3)
	player.set_stat("accuracy", 10)
	
	enemy.set_stat("damage", 1)
	enemy.set_stat("accuracy", 5)
	
	#starts combat with given seed
	start_combat(player, enemy, 800.5)
	
	pass


#prepares combat to start
func start_combat(player, enemy, seeded = null):
	emit_signal("UI_get_ready")
	combat_in_progress = true
	state = 0
	self.player_moves = player.get_all_moves()
	self.player = player
	self.enemy = enemy
	if seeded == null:
		randomize()
	else:
		seed(seeded)
	
#Whenever a button on the UI is pressed, this method resolves
func on_button_pressed(button_id):
	if !combat_in_progress: #combat complete, do nothing
		return
	if(state == 0): #Waiting for main combat menu button press
		if(button_id == 0): #Fight was chosen
			var move_names = []
			for move in player_moves:
				move_names.append(move.name)
			emit_signal("show_fighting_options", player_moves)
			state = 1
		if(button_id == 1): #flee was chosen
			attempt_to_flee()
			yield($combatInterface, "finished_displaying_text")
			resolve_enemy_attack()
			yield($combatInterface, "finished_displaying_text")
			check_player_is_dead()
			emit_signal("show_menu_options")
			state = 0
			pass
	elif(state == 1): #waiting for move selection
		#gets the move chosen
		var move_chosen = player_moves[button_id]
		emit_signal("output_only")
		
		#Resolves player's attack
		resolve_player_attack(move_chosen)
		yield($combatInterface, "finished_displaying_text")
		var enemy_is_dead = check_enemy_is_dead()
		#enemy is alive
		
		#Resolves enemy's attack
		if enemy_is_dead:
			yield($combatInterface, "finished_displaying_text")
			finish_combat()
		else:
			resolve_enemy_attack()
			yield($combatInterface, "finished_displaying_text")
		
			var player_is_dead = check_player_is_dead()
			
			if player_is_dead:
				yield($combatInterface, "finished_displaying_text")
				finish_combat()
				
		#returns to initial state
		state = 0
		emit_signal("show_menu_options")


#resolves a player's attack
func resolve_player_attack(move_chosen):
	var resulting_damage = get_resulting_damage(move_chosen, player, enemy)
	print("player deal: " + str(resulting_damage))
	if(resulting_damage != null):
		#TODO: add logic if damage can ever be less than 0
		enemy.health = enemy.health - resulting_damage
		emit_signal("display_text", "You hit the enemy for " + str(resulting_damage))
		
	else:
		emit_signal("display_text", "You missed")
		

#resolves an enemy's attack
func resolve_enemy_attack():
	var enemy_move = enemy.get_all_moves()[randi() % enemy.get_all_moves().size()]
	var resulting_damage = get_resulting_damage(enemy_move, enemy, player)
	print("enemy dealt :" + str(resulting_damage))
	if(resulting_damage != null):
		#TODO: add logic if damage can ever be less than 0
		player.health = player.health - resulting_damage
		emit_signal("display_text", "Player got hit for " + str(resulting_damage))
	else:
		emit_signal("display_text", "Enemy missed")
		
		
		
#gets the resulting damage. 0 represents a hit for no damage, null represents a miss
func get_resulting_damage(move, attacker, target):
	var to_hit = move.get_accuracy() + attacker.get_stat("accuracy")
	var damage = move.get_damage() + attacker.get_stat("damage")
	var chance = randi() % 100
	if(chance < to_hit):
		return damage
	else:
		return null
		
		
func _on_UIBox_btnPressed(button_id):
	on_button_pressed(button_id)

func attempt_to_flee():
	emit_signal("display_text", "attempting to flee")
	if (randi() % 2):
		emit_signal("display_text", "You successfully flee!")
		emit_signal("combat_finished", player, enemy, "Player fled")
		finish_combat()
	else:
		emit_signal("display_text", "You didn't manage to flee!")
	
	
func check_enemy_is_dead():
	if(enemy.health <= 0): #if enemy is dead
		emit_signal("display_text", "Enemy defeated")
		emit_signal("combat_finished", player, enemy, "Player won")
		finish_combat()
		return true
	return false

func check_player_is_dead():
	if(player.health <= 0): #if player is dead
		emit_signal("display_text", "Player defeated")
		emit_signal("combat_finished", player, enemy, "Enemy won")
		finish_combat()
		return true
	return false
		


func finish_combat():
	state = 0
	combat_in_progress = false
	pass
	
#func display_text(text):
#	emit_signal("display_text", text)
#	print("finished here")
#	yield($combatInterface, "finished_displaying_text")
#	print("Second part")

