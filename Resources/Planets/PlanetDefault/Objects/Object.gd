# Filename: object.gd
# Breif: Make block disapear when the bodie player passes over it
# Author: Vikram Singh Kainth
# Created: 03/11/2018

extends Node2D

## check to see if the player is over the block
## => if so then the player is able to make the block disapear 
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			queue_free()
