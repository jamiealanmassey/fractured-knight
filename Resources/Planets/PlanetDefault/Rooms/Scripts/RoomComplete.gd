# Filename: RoomComplete.gd
# Breif: Allows the creator of rooms to change a room by addng this node to a scene
# Author: Vikram Singh Kainth
# Created: 28/10/2018

extends Area2D

# Getting the next world and adding it to the var, world 
export(String, FILE, "*.tscn") var world

# Checking if the player is in the nect world block
# Then changing the world
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(world)
