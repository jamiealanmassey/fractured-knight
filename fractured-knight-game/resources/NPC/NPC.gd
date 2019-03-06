extends Node2D


# The combat actor for the NPC. Needs to be set on creation
export (Resource) var combat_actor
# Dialogue name for use by the dialogue system
export (String) var dialogue_name
# Animted sprite frames for animated sprite node 
export (SpriteFrames) var frames
export (int) var collision_size = 10
export (float) var interaction_radius = 150
export (float) var interaction_offset = 80

var interact_icon_tweener = null
var sprite_scale_x = 0
var sprite_position_y = 0

func _ready():
	$AnimatedSprite.frames = self.frames
	$CollisionDetection/CollisionShape2D.shape.radius = collision_size
	sprite_scale_x = $InteractionIcon.scale.x
	sprite_position_y = $InteractionIcon.position.y
	$InteractionIcon.scale.x = 0
	$InteractionIcon.modulate.a = 0
	interact_icon_tweener = Tween.new()
	self.add_child(interact_icon_tweener)

func _on_Area2D_body_entered(body):
	interact_icon_tweener.stop_all()
	interact_icon_tweener.interpolate_property($InteractionIcon, 'position:y', $InteractionIcon.position.y, sprite_position_y - interaction_offset, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	interact_icon_tweener.interpolate_property($InteractionIcon, 'scale:x', $InteractionIcon.scale.x, sprite_scale_x, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	interact_icon_tweener.interpolate_property($InteractionIcon, 'modulate:a', $InteractionIcon.modulate.a, 1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	interact_icon_tweener.start()

func _on_Area2D_body_exited(body):
	interact_icon_tweener.stop_all()
	interact_icon_tweener.interpolate_property($InteractionIcon, 'position:y', $InteractionIcon.position.y, sprite_position_y, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	interact_icon_tweener.interpolate_property($InteractionIcon, 'scale:x', $InteractionIcon.scale.x, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	interact_icon_tweener.interpolate_property($InteractionIcon, 'modulate:a', $InteractionIcon.modulate.a, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	interact_icon_tweener.start()
	
