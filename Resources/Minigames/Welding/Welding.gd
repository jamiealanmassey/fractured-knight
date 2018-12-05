# Title: Welding.gd
# Breif: 
# Created: 05/10/18 
# Author: Vikram Singh Kainth

extends KinematicBody2D

const UP  = Vector2(0, 0)
const MAX_SPEED = 200
const ACCELERATION = 50

var motion = Vector2()
 
func _physics_process(delta):

	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)

	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)

	elif Input.is_action_just_pressed("ui_up"):
		motion.y = max(motion.y - ACCELERATION, -MAX_SPEED)

	elif Input.is_action_just_pressed("ui_down"):
		motion.y = max(motion.y + ACCELERATION, MAX_SPEED)

	else:
		motion.x = 0;

	motion = move_and_slide(motion, UP)
	pass