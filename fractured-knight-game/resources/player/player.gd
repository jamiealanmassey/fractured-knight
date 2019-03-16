# Filename: player.gd
# Brief: Allows the player to control and interact with the player and holds
#        valuable information about the player state
# Author: Jamie Massey
# Created: 04/11/2018

extends KinematicBody2D

export(float) var moveSpeed = 250
export(float) var velocitySpeed = 1
export (Resource) var combat_actor

var velocity = Vector2()
var key_states = []
var lock_movement = false

signal player_moved

## Defines the KeyState as tuples of (bool, int, string)
##   => where bool is pressed state, and
##   => where int is timestamp of when they key was pressed, and
##   => where string is the identifier of the actual key
class KeyState:
	func _init(name):
		self.state = false
		self.stamp = 0
		self.name = name
	
	var state = false
	var stamp = 0
	var name = ''

## Custom sorting class for KeyState objects (sorts by timestamp)
class KeyStateSorter:
	static func sort(a, b):
		if (a.stamp < b.stamp):
			return true
		return false

## Updates a single key input based on its name; if it has
## been pressed then turn the state on and save the timestamp
func update_input(key_state):
	if (Input.is_action_pressed(key_state.name)):
		key_state.state = true
		key_state.stamp = OS.get_ticks_msec()
	else:
		key_state.state = false

func sort_input():
	key_states.sort_custom(KeyStateSorter, 'sort')

## Helper function to calculate the input for this frame of
## the game by updating all key states
func calulate_input():
	velocity = Vector2()
	for key_index in range(key_states.size()):
		update_input(key_states[key_index])
	
	if lock_movement:
		return
	
	key_states.sort_custom(KeyStateSorter, 'sort')
	var moving = false
	for key in key_states:
		if (key.state):
			match key.name:
				'left':
					velocity.x -= velocitySpeed * moveSpeed
					$Sprite.play('left')
					moving = true
				'right':
					velocity.x += velocitySpeed * moveSpeed
					$Sprite.play('right')
					moving = true
				'up':
					velocity.y -= velocitySpeed * moveSpeed
					$Sprite.play('up')
					moving = true
				'down':
					velocity.y += velocitySpeed * moveSpeed
					$Sprite.play('down')
					moving = true
			emit_signal('player_moved', self.position)
			break
		
	if (!moving):
		$Sprite.stop_moving()
		pass


func _ready():
	key_states = [
	KeyState.new('left'), 
	KeyState.new('right'), 
	KeyState.new('up'), 
	KeyState.new('down')]

func _process(delta):
	calulate_input()

func _physics_process(delta):
	move_and_slide(velocity)
