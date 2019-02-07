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

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


#prepares combat to start
func start_combat(player, enemy, seeded = null):
	emit_signal("UI_get_ready")
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
	if(state == 0): #Waiting for main combat menu button press
		if(button_id == 0): #Fight was chosen
			emit_signal("show_fighting_options", player_moves)
			state = 1
	elif(state == 1): #waiting for move selection
		#gets the move chosen
		var move_chosen = player_moves[button_id]
		emit_signal("output_only")
		
		#Resolves player's attack
		resolve_player_attack(move_chosen)
		if(enemy.health <= 0): #if enemy is dead
			emit_signal("display_text", "Enemy defeated")
			emit_signal("combat_finished", player, enemy, "Player won")
			pass
		#enemy is alive
		
		#Resolves player's attack
		resolve_enemy_attack()
		if(player.health <= 0): #if player is dead
			emit_signal("display_text", "Player defeated")
			emit_signal("combat_finished", player, enemy, "Enemy won")
			pass
		
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
	var to_hit = calculate_to_hit(move) + attacker.get_stat("accuracy")
	var damage = calculate_damage(move) + attacker.get_stat("damage")
	var chance = randi() % 100
	if(chance < to_hit):
		return damage
	else:
		return null
		
	
	
		
func calculate_to_hit(move):
	if (move.weapon != null):
		return move.accuracy + move.weapon.get_attribute("accuracy")
	else:
		return move.accuracy
	
func calculate_damage(move):
	if (move.weapon != null):
		return move.damage + move.weapon.get_attribute("damage")
	else:
		return move.damage
	
	
	
	
	
	
	
	