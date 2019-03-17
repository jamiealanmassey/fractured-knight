extends Sprite

enum directions {up, left, down, right}

var current_direction
var moving = false
var starting_x = 0

func _ready():
	starting_x = self.position.x
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#Plays a frame of animation for movement
func play(direction):
	# Whilst waiting, play the 0th frame. Whilst moving, play 1st to 8th frame For up, down and right. (use animation player). 
	# For left and right, play all frames
	if direction == 'up' && current_direction != 'up': # frames 0-8
		$AnimationPlayer.play('up')
		pass
	elif direction == 'left' && current_direction != 'left': # frames 9-17
		$AnimationPlayer.play('left')
		pass
	elif direction == 'down' && current_direction != 'down': # frames 18-26
		$AnimationPlayer.play('down')
		pass
	elif direction == 'right' && current_direction != 'right': # frames 27-35
		$AnimationPlayer.play('right')
		pass
	current_direction = direction
	pass
	
func stop_moving():
	match current_direction:
		'up':
			frame = 0
		'left':
			frame = 9
		'down':
			frame = 18
		'right':
			frame = 27

func combat_started():
	self.show()

# When this sprite attacks, run this
func on_attack_hit(damage):
	attack_animation()
	
	
func on_attack_miss():
	attack_animation()
	
func attack_animation():
	var velocity = 10 # Amount and direction sprite will move
	var i = 0
	while i < 10:
		if (self.position.x >= starting_x + 50):
			velocity = -velocity
		self.position.x += velocity
		i += 1
		yield($movement_timer, "timeout")
	pass
	
# when this sprite gets hit, run this
func on_received_hit(damage):
	if damage == 0:
		# play hit for no damage
		pass
	else:
		# play hit for some damage
		# May need to move to its own function to have yield work properly 
		player_shake()
			
		var j = 0
		$Label.text = str(damage)
		print($Label.text)
		while j < 20:
			
			$Label.rect_position.y -= 3
			yield($damage_timer, "timeout")
			j += 1
		
		$Label.text = ""
		$Label.rect_position.y += 20 * 3
	pass
	
func player_shake():
	var i = 0
	var velocity = 3
	while i < 39:
		print(self.position.x)
		if (self.position.x >= 21 + starting_x):
			velocity = -3
		elif (self.position.x <= -21 + starting_x):
			velocity = 3
		self.position.x += velocity
		yield($movement_timer, "timeout")
		i += 1