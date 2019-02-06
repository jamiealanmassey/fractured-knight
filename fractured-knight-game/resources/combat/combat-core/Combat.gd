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
func start_combat(player, enemy):
	emit_signal("UI_get_ready")
	state = 0
	self.player_moves = player.get_all_moves()
	self.player = player
	self.enemy = enemy
	randomize()
	
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
	var chosen_move = player_moves[move_chosen]
	var to_hit = calculate_to_hit(chosen_move) + player.stats["accuracy"]
	var damage = calculate_damage(chosen_move) + player.stats["damage"]
	var chance = randi() % 100 +1
	if(chance < to_hit):
		enemy.health - damage
		emit_signal("display_text", "You hit the enemy for" + damage)
	else:
		emit_signal("display_text", "You missed")
		

#resolves an enemy's attack
func resolve_enemy_attack():
	var enemy_move = enemy.get_all_moves()[randi() % enemy.get_all_moves().size]
	var to_hit = calculate_to_hit(enemy_move) + enemy.stats["accuracy"]
	var damage = calculate_damage(enemy_move) + enemy.stats["damage"]
	var chance = randi() % 100+1
	if(chance < to_hit ):
		player.health - damage
		emit_signal("display_text", "Player got hit for " + damage)
	else:
		emit_signal("display_text", "Enemy missed")
		
func calculate_to_hit(move):
	return move.accuracy + move.weapon.get_attribute("accuracy")
	
func calculate_damage(move):
	return move.damage + move.weapon.get_attribute("damage")