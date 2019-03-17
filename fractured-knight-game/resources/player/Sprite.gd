extends Sprite

enum directions {up, left, down, right}

var current_direction
var moving = false

func _ready():
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
