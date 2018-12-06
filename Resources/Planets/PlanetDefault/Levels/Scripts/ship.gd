extends Sprite
# Filename: RoomComplete.gd
# Breif: changes to the next room for thr player
# Author: Vikram Singh Kainth
# Created: 02/11/2018

#getting the next world and adding it to the var, world 
export(String, FILE, "*.tscn") var world

#Checking if the player is in the nect world block
#Then changing the world
func _physics_process(delta):
	if $Player == self:
		get_tree().change_scene(world)