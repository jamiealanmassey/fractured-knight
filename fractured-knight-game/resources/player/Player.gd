# Filename: player.gd
# Brief: Allows the player to control and interact with the player and holds
#        valuable information about the player state
# Author: Jamie Massey
# Created: 04/11/2018

extends KinematicBody2D

export(float) var moveSpeed = 250
export(float) var velocitySpeed = 1

var velocity = Vector2()
var keyStates = []
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
	var name = ""

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

## Helper function to calculate the input for this frame of
## the game by updating all key states
func calulate_input():
	velocity = Vector2()
	for key_index in range(keyStates.size()):
		update_input(keyStates[key_index])
	
	if lock_movement:
		return
	
	keyStates.sort_custom(KeyStateSorter, "sort")
	var moving = false
	for key in keyStates:
		if (key.state):
			match key.name:
				"left":
					velocity.x -= velocitySpeed * moveSpeed
					#$Sprite.play("Left")
					moving = true
				"right":
					velocity.x += velocitySpeed * moveSpeed
					#$Sprite.play("Right")
					moving = true
				"up":
					velocity.y -= velocitySpeed * moveSpeed
					#$Sprite.play("up")
					moving = true
				"down":
					velocity.y += velocitySpeed * moveSpeed
					#$Sprite.play("Down")
					moving = true
			emit_signal("player_moved")
			break
		
	if (!moving):
		pass#$Sprite.frame = 0

func _ready():
	keyStates = [
	KeyState.new("left"), 
	KeyState.new("right"), 
	KeyState.new("up"), 
	KeyState.new("down")]

func _process(delta):
	calulate_input()

func _physics_process(delta):
	move_and_slide(velocity)
