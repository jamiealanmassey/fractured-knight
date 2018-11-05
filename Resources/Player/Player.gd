# Filename: Player.gd
# Brief: Allows the player to control and interact with the player and holds
#        valuable information about the player state
# Author: Jamie Massey
# Created: 04/11/2018

extends KinematicBody2D

export(float) var moveSpeed = 250
export(float) var velocitySpeed = 1

var velocity = Vector2()

func _ready():
	pass

func calulate_input():
	velocity = Vector2()
	if (Input.is_action_pressed("right")):
		velocity.x += velocitySpeed
	elif (Input.is_action_pressed("left")):
		velocity.x -= velocitySpeed
	elif (Input.is_action_pressed("up")):
		velocity.y -= velocitySpeed
	elif (Input.is_action_pressed("down")):
		velocity.y += velocitySpeed
		
	velocity = velocity.normalized() * moveSpeed
	
func _physics_process(delta):
	calulate_input()
	move_and_slide(velocity)
