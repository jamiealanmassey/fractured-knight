# Filename: RoomComplete.gd
# Breif: 
# Author: 
# Created: 
extends Area2D

#getting the next world and adding it to the var, world 
export(String, FILE, "*.tscn") var world

#Checking if the player is in the nect world block
#Then changing the world
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(world)
