extends Node
#emitted when combat is complete
signal combat_finished
#emitted when initalised to signal that the UI needs to start in its initial state
signal UI_get_ready
#emitted when the text passed as an argument needs to be displayed 
signal display_text
# emitted when options need to be displayed in buttons
signal display_options

# emitted when the player's health changes
signal player_health_update
# emitted when the enemy's health changes
signal enemy_health_update

# emitted when player attacks and hits, int arg as damage
signal player_attack_hit
# emitted when player attacks and misses
signal player_attack_miss
# emitted when player dies
signal player_died

# emitted when enemy attacks and hits, int arg as damage
signal enemy_attack_hit
# emitted when enemy attacks and misses
signal enemy_attack_miss
# emitted when enemy dies
signal enemy_died



enum states {MAIN_MENU, MOVE_SELECTION}
enum main_menu_choices {FIGHT, FLEE}
#Current state the combat system is in. 0= main menu, 1= waiting for move input
var state
#The moves the player can do
var player_moves
# player and enemy actors
var player = null
var enemy = null
var combat_in_progress = false

func _ready():
	pass


#prepares combat to start
func start_combat(player, enemy, seeded = null):
	combat_in_progress = true
	state = states.MAIN_MENU
	self.player = player
	self.enemy = enemy
	self.player_moves = self.player.combat_actor.get_all_moves()
	
	$enemy_combat_sprite.frames = enemy.frames
	#$player_combat_sprite.frames = player.frames 
	
	$enemy_health_bar.max_health = self.enemy.combat_actor.health
	if seeded == null:
		randomize()
	else:
		seed(seeded)
		
	emit_signal("UI_get_ready")
	show_menu_options()
	
#Whenever a button on the UI is pressed, this method resolves
func on_button_pressed(button_id):
	if !combat_in_progress: #combat complete, do nothing
		return
		
	match state: # switches based on current state of the system
		states.MAIN_MENU: 
			match button_id: #switches to either fight or flee
				# Fight was chosen
				main_menu_choices.FIGHT:
					var move_names = []
					for move in player_moves:
						move_names.append(move.move_name)
					show_move_options()
					state = states.MOVE_SELECTION
					
				# Flee was chosen
				main_menu_choices.FLEE: 
				# Attempt to flee and wait for text output x2
					attempt_to_flee()
					yield($combatInterface, "finished_displaying_text")
					yield($combatInterface, "finished_displaying_text")
					
					# Player didn't manage to flee, enemy attacks
					if combat_in_progress:
						resolve_enemy_attack()
						yield($combatInterface, "finished_displaying_text")
					
					# Check player is alive and whether to continue
					check_player_is_dead()
					if combat_in_progress:
						show_menu_options()
						state = states.MAIN_MENU
		
		states.MOVE_SELECTION: # switches to player having chosen a move
			#gets the move chosen
			var move_chosen = player_moves[button_id]
			emit_signal("output_only")
			
			#Resolves player's attack
			resolve_player_attack(move_chosen)
			yield($combatInterface, "finished_displaying_text")
			var enemy_is_dead = check_enemy_is_dead()
			
			if enemy_is_dead: #Enemy dead, wait for enemy defeated text then finish
				yield($combatInterface, "finished_displaying_text")
				finish_combat()
			else: #Resolves enemy's attack
				resolve_enemy_attack()
				yield($combatInterface, "finished_displaying_text")
			
				# check for player death
				var player_is_dead = check_player_is_dead()
				if player_is_dead:
					yield($combatInterface, "finished_displaying_text")
					finish_combat()
					
			#returns to initial state
			state = states.MAIN_MENU
			if combat_in_progress:
				show_menu_options()
				pass



#resolves a player's attack
func resolve_player_attack(move_chosen):
	var resulting_damage = get_resulting_damage(move_chosen, player.combat_actor, enemy.combat_actor)
	print("player deal: " + str(resulting_damage))
	if(resulting_damage != null):
		#TODO: add logic if damage can ever be less than 0
		enemy.combat_actor.health = enemy.combat_actor.health - resulting_damage
		emit_signal("enemy_health_update", enemy.combat_actor.health)
		emit_signal("player_attack_hit", resulting_damage)
		emit_signal("display_text", "You hit the enemy for " + str(resulting_damage))
	else:
		emit_signal("player_attack_miss")
		emit_signal("display_text", "You missed")
		

#resolves an enemy's attack
func resolve_enemy_attack():
	var enemy_move = enemy.combat_actor.get_all_moves()[randi() % enemy.combat_actor.get_all_moves().size()]
	var resulting_damage = get_resulting_damage(enemy_move, enemy.combat_actor, player.combat_actor)
	print("enemy dealt :" + str(resulting_damage))
	if(resulting_damage != null):
		#TODO: add logic if damage can ever be less than 0
		player.combat_actor.health = player.combat_actor.health - resulting_damage
		emit_signal("player_health_update", player.combat_actor.health)
		emit_signal("enemy_attack_hit", resulting_damage)
		emit_signal("display_text", "Player got hit for " + str(resulting_damage))
	else:
		emit_signal("enemy_attack_miss")
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
		


func attempt_to_flee():
	emit_signal("display_text", "attempting to flee")
	yield($combatInterface, "finished_displaying_text")
	if (randi() % 2):
		emit_signal("display_text", "You successfully flee!")
		emit_signal("combat_finished", player, enemy, "Player fled")
		finish_combat()
	else:
		emit_signal("display_text", "You didn't manage to flee!")
	
	
func check_enemy_is_dead():
	print (enemy.combat_actor.health)
	if (enemy.combat_actor.health <= 0): #if enemy is dead
		emit_signal("display_text", "Enemy defeated")
		emit_signal("enemy_died")
		emit_signal("combat_finished", player, enemy, "Player won")
		finish_combat()
		return true
	return false

func check_player_is_dead():
	if(player.combat_actor.health <= 0): #if player is dead
		emit_signal("display_text", "Player defeated")
		emit_signal("player_died")
		emit_signal("combat_finished", player, enemy, "Enemy won")
		finish_combat()
		return true
	return false
		

# Tells UI to show initial menu options
func show_menu_options():
	var menu_options = []
	for option in main_menu_choices.keys():
		option = option.to_lower()
		option = option.capitalize()
		menu_options.append(option)
	emit_signal("display_options", menu_options)
	
# Tells UI to show player's moves
func show_move_options():
	var move_names = []
	for move in player_moves:
		move_names.append(move.move_name)
	emit_signal("display_options", move_names)
	

# Finishes combat
func finish_combat():
	state = states.MAIN_MENU
	combat_in_progress = false

# Sets the background image's filepath
func set_background_image(image_filepath):
	$background_image.texture = image_filepath




func on_attack_miss():
	pass # replace with function body
