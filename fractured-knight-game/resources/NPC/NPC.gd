extends Node2D

enum NPCType {
	Friendly,
	Neutral,
	Hostile
}

# The combat actor for the NPC. Needs to be set on creation
export (Resource) var combat_actor
# Dialogue name for use by the dialogue system
export (String) var dialogue_name
# Animted sprite frames for animated sprite node 
export (SpriteFrames) var frames
export (int) var collision_size = 10
export (int) var npc_type = 0
export (float) var interaction_radius = 150
export (float) var interaction_offset = 80

var interact_icon_tweener = null
var sprite_scale_x = 0
var sprite_position_y = 0
var can_interact = false

const FRIENDLY = 0
const NEUTRAL = 1
const HOSTILE = 2

func _ready():
	$AnimatedSprite.frames = self.frames
	$CollisionDetection/CollisionShape2D.shape.radius = collision_size
	sprite_scale_x = $InteractionIcon.scale.x
	sprite_position_y = $InteractionIcon.position.y
	$InteractionIcon.scale.x = 0
	$InteractionIcon.modulate.a = 0
	interact_icon_tweener = Tween.new()
	self.add_child(interact_icon_tweener)
	
	if self.npc_type == self.FRIENDLY && dialogue_name == null:
		print('warning friendly NPC is missing dialogue file')
	

func _process(delta):
	if can_interact && dialogue_name != null && Input.is_action_just_pressed('interact'):
		get_node('/root/LevelManager').start_dialogue(dialogue_name)
	

func _on_Area2D_body_entered(body):
	if self.npc_type == self.FRIENDLY && dialogue_name != null:
		interact_icon_tweener.stop_all()
		interact_icon_tweener.interpolate_property($InteractionIcon, 'position:y', $InteractionIcon.position.y, sprite_position_y - interaction_offset, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		interact_icon_tweener.interpolate_property($InteractionIcon, 'scale:x', $InteractionIcon.scale.x, sprite_scale_x, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		interact_icon_tweener.interpolate_property($InteractionIcon, 'modulate:a', $InteractionIcon.modulate.a, 1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		interact_icon_tweener.start()
		can_interact = true

func _on_Area2D_body_exited(body):
	if self.npc_type == self.FRIENDLY && dialogue_name != null:
		interact_icon_tweener.stop_all()
		interact_icon_tweener.interpolate_property($InteractionIcon, 'position:y', $InteractionIcon.position.y, sprite_position_y, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		interact_icon_tweener.interpolate_property($InteractionIcon, 'scale:x', $InteractionIcon.scale.x, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		interact_icon_tweener.interpolate_property($InteractionIcon, 'modulate:a', $InteractionIcon.modulate.a, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		interact_icon_tweener.start()
		can_interact = false
	
