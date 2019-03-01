extends Node2D


# The combat actor for the NPC. Needs to be set on creation
export (Resource) var combat_actor
# Dialogue name for use by the dialogue system
export (String) var dialogue_name
# Animted sprite frames for animated sprite node 
export (SpriteFrames) var frames
export (int) var collision_size = 10


func _ready():
	$AnimatedSprite.frames = self.frames
	$CollisionDetection/CollisionShape2D.shape.radius = collision_size
	pass

