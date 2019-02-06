extends Node
signal combat_finished
#Current state the combat system is in. 0= main menu, 1= waiting for move input
var state
#The moves the player can do
var moves
var player
var enemy

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

#prepares combat to start
func start_combat(player, enemy):
	$UI.get_ready()
	state = 0
	self.moves = player.get_moves()
	self.player = player
	self.enemy = enemy
	randomize()
	
#Whenever a button on the UI is pressed, this method resolves
func on_button_pressed(button_id):
	if(state == 0): #Waiting for main combat menu button press
		if(button_id == 0): #Fight was chosen
			$UI.change_to_fighting()
			$UI.sets_buttons(moves)
			state = 1
	elif(state == 1): #waiting for move selection
		#gets the move chosen
		var move_chosen = player_moves[button_id]
		$UI.change_to_output_only()
		
		#Resolves player's attack
		resolve_player_attack(move_chosen)
		if(enemy.health <= 0): #if enemy is dead
			$UI.set_text("Enemy defeated")
			emit_signal("combat_finished", player, enemy, "Player won")
			pass
		#enemy is alive
		
		#Resolves player's attack
		resolve_enemy_attack()
		if(player.health <= 0): #if player is dead
			$UI.set_text("Player defeated")
			emit_signal("combat_finished", player, enemy, "Enemy won")
			pass
		
		#returns to initial state
		state = 0
		$UI.change_to_start_menu()

#resolves a player's attack
func resolve_player_attack(move_chosen):
	var to_hit = moves[move_chosen].accuracy+moves[move_chosen].weapon.attributes_buffs["accuracy"]+player.stats["accuracy"]
	var damage = moves[move_chosen].damage+moves[move_chosen].weapon.attributes_buffs["damage"]+player.stats["damage"]
	var chance = randi() % 100 +1
	if(chance < to_hit):
		enemy.health - damage
		$UI.show_text("You hit the enemy for"+damage)
	else:
		$UI.show_text("You missed")
		

#resolves an enemy's attack
func resolve_enemy_attack():
	var enemy_move = enemy.moves[randi() % moves.size]
	var to_hit = enemy_move.accuracy+enemy_move.weapon.attributes_buffs["accuracy"]+enemy.stats["accuracy"]
	var damage = enemy_move.damage+enemy_move.weapon.attributes_buffs["damage"]+player.stats["damage"]
	var chance = randi() % 100+1
	if(chance < to_hit ):
		player.health - damage
		$UI.show_text ("Player got hit for"+damage)
	else:
		$UI.show_text("Enemy missed")