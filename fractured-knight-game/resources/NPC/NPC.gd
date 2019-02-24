extends Node2D



# The combat actor for the NPC. Needs to be set on creation
var combat_actor
# Dialogue name for use by the dialogue system
export (String) var dialogue_name
# Animted sprite frames for animated sprite node 
export (SpriteFrames) var frames
export (int) var collision_size = 10
# values to be used by the combat actor 
export (int) var health = 10
export (int) var base_accuracy = 50
export (int) var base_damage = 3



func _ready():
	$AnimatedSprite.frames = self.frames
	combat_actor = load("res://resources/combat/combat-core/actor.tscn").instance()
	combat_actor.init(health)
	combat_actor.set_stat("accuracy", base_accuracy)
	combat_actor.set_stat("damage", base_damage)
	$CollisionDetection/CollisionShape2D.shape.radius(collision_size)
	pass

func add_weapon(weapon):
	combat_actor.add_weapon(weapon)
	
func add_move(move):
	combat_actor.add_move(move)
