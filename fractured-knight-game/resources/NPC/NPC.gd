extends Node2D

enum NPCType { Friendly, Hostile }
enum NPCState { Idle, Patrol, Chase, Return, Talk }
enum NPCPatrol { Continuous, ForwardBack, BackForward, Once, OnceReverse, Reverse, None }

# The combat actor for the NPC. Needs to be set on creation
export (Resource) var combat_actor = null

# Dialogue name for use by the dialogue system
export (String) var dialogue_name = null

# Animted sprite frames for animated sprite node and states/general variables
export (SpriteFrames) var frames
export (NPCType) var npc_type = NPCType.Friendly
export (NPCState) var npc_state = NPCState.Patrol
export (NPCPatrol) var npc_patrol = NPCPatrol.Continuous
export (int) var interaction_radius = 40
export (int) var chase_radius = 250
export (float) var movement_speed = 150
export (float) var min_idle_time = 0.5
export (float) var max_idle_time = 1.0
export (float, 0, 1) var idle_chance = 0.5

# Interaction animation tweakable variables
export (float) var interaction_offset = 80
export (float) var interaction_anim_speed = 0.25

# Patrol and Chase tweakable variables
export (Array, Vector2) var patrol_path

# Internal variables
var interact_icon_tweener = null
var interact_scale_x = 0
var interact_position_x = 0
var is_inside = false
var idle_timer = null
var current_player = null
var npc_state_last = NPCState.Patrol
var patrol_curr_index = 0
var patrol_velocity = Vector2()
var patrol_dist_bias = 5
var patrol_last_location = Vector2()

var chase_area = null
var chase_area_collider = null
var chase_area_shape = null
var chase_distance = 0

func _ready():
	interact_scale_x = $InteractionIcon.scale.x
	interact_position_x = $InteractionIcon.position.y
	interact_icon_tweener = Tween.new()
	$InteractionArea2D/CollisionShape2D.shape.radius = interaction_radius
	$InteractionIcon.scale.x = 0
	$InteractionIcon.modulate.a = 0
	$AnimatedSprite.frames = self.frames
	npc_state_last = npc_state
	idle_timer = Timer.new()
	idle_timer.one_shot = true
	idle_timer.autostart = false
	idle_timer.connect('timeout', self, '_on_idle_timeout')
	self.add_child(interact_icon_tweener)
	self.add_child(idle_timer)
	
	if (npc_type == NPCType.Hostile):
		chase_distance = chase_radius * chase_radius
		chase_area = Area2D.new()
		chase_area_collider = CollisionShape2D.new()
		chase_area_shape = CircleShape2D.new()
		chase_area_shape.radius = chase_radius
		chase_area_collider.set_shape(chase_area_shape)
		chase_area.add_child(chase_area_collider)
		chase_area.set_collision_mask_bit(16, true)
		chase_area.connect('body_entered', self, '_on_chase_body_entered')
		chase_area.connect('body_exited', self, '_on_chase_body_exited')
		self.add_child(chase_area)
	
	if (npc_patrol == NPCPatrol.BackForward || npc_patrol == NPCPatrol.Reverse):
		patrol_curr_index = patrol_path.size() - 1
	
	if (combat_actor != null):
		combat_actor = combat_actor.duplicate(true)
	
	if self.npc_type == NPCType.Friendly && dialogue_name == null:
		print('warning friendly NPC is missing dialogue file')
	

func _process(delta):
	patrol_velocity = Vector2()
	match npc_type:
		NPCType.Friendly: 
			self.process_friendly_npc()
		NPCType.Hostile:
			self.process_hostile_npc()
		_:
			self.process_friendly_npc()
		
	
func _physics_process(delta):
	move_and_slide(patrol_velocity)

func process_hostile_npc():
	match self.npc_state:
		NPCState.Idle:
			pass
		NPCState.Patrol:
			self.process_patrol()
		NPCState.Chase:
			if current_player != null:
				var position_b = patrol_last_location
				var dist = (pow(position.x - position_b.x, 2) + pow(position.y - position_b.y, 2))
				calculate_movement(position, current_player.position)
				if dist > chase_distance + (15 * 15):
					switch_npc_state(NPCState.Return)
			else:
				switch_npc_state(NPCState.Return)
		NPCState.Return:
			if calculate_movement(position, patrol_last_location):
				switch_npc_state(NPCState.Patrol)

func process_friendly_npc():
	var level_manager = get_node('/root/LevelManager')
	match self.npc_state:
		NPCState.Talk:
			if !level_manager.is_dialogue_playing():
				self.switch_npc_state(NPCState.Idle)
				self.start_idling()
		NPCState.Idle:
			self.process_friendly_interaction(level_manager)
		NPCState.Patrol:
			self.process_radius_interaction()
			self.process_friendly_interaction(level_manager)
			self.process_patrol()
		
	

func process_radius_interaction():
	if is_inside():
		start_idling()

func process_friendly_interaction(level_manager):
	if !is_inside || dialogue_name == null:
		return
	
	if Input.is_action_just_pressed('interact'):
		level_manager.start_dialogue(dialogue_name)
		self.switch_npc_state(NPCState.Talk)
	

func process_patrol():
	if (patrol_path == null || patrol_path.size() == 0):
		switch_npc_state(NPCState.Idle)
		return
	
	if (calculate_movement(position, patrol_path[patrol_curr_index])):
		match self.npc_patrol:
			NPCPatrol.Continuous:
				patrol_curr_index = patrol_curr_index + 1
				patrol_curr_index = 0 if patrol_curr_index == patrol_path.size() - 1 else patrol_curr_index
			NPCPatrol.BackForward:
				patrol_curr_index = patrol_curr_index - 1
				npc_patrol = NPCPatrol.ForwardBack if patrol_curr_index == 0 else NPCPatrol.BackForward
			NPCPatrol.ForwardBack:
				patrol_curr_index = patrol_curr_index + 1
				npc_patrol = NPCPatrol.BackForward if patrol_curr_index == patrol_path.size() - 1 else NPCPatrol.ForwardBack
			NPCPatrol.Once:
				patrol_curr_index = patrol_curr_index + 1
				npc_patrol = NPCPatrol.None if patrol_curr_index == patrol_path.size() - 1 else NPCPatrol.Once
			NPCPatrol.Reverse:
				patrol_curr_index = patrol_curr_index - 1
				npc_patrol = NPCPatrol.None if patrol_curr_index == 0 else NPCPatrol.Reverse
			NPCPatrol.OnceReverse:
				patrol_curr_index = patrol_curr_index + 1
				npc_patrol = NPCPatrol.Reverse if patrol_curr_index == patrol_path.size() - 1 else NPCPatrol.OnceReverse
			
		if (randf() < idle_chance):
			start_idling()

func calculate_movement(position_a, position_b):
	var dist_x = position_b.x - position_a.x
	var dist_y = position_b.y - position_a.y
	var dist_x_abs = abs(dist_x)
	var dist_y_abs = abs(dist_y)
	
	if (dist_x_abs > patrol_dist_bias && dist_x_abs >= dist_y_abs):
		patrol_velocity.x = max(-1, min(1, dist_x)) * movement_speed
	elif (dist_y_abs > patrol_dist_bias):
		patrol_velocity.y = max(-1, min(1, dist_y)) * movement_speed
	
	return (abs(dist_x) <= patrol_dist_bias && abs(dist_y) <= patrol_dist_bias)

func switch_npc_state(new_state):
	npc_state_last = npc_state
	npc_state = new_state
	
	# After setting the new state we may need to pause idling
	if (idle_timer.time_left > 0):
		idle_timer.paused = npc_state != NPCState.Idle
	

func start_idling():
	if (idle_timer.time_left <= 0.0):
		idle_timer.wait_time = rand_range(min_idle_time, max_idle_time)
		idle_timer.start()
		self.switch_npc_state(NPCState.Idle)
	

func is_idling():
	return self.idle_timer.time_left > 0

func _on_idle_timeout():
	self.switch_npc_state(npc_state_last)

func _on_chase_body_entered(body):
	current_player = body
	patrol_last_location = position if (self.npc_state == NPCState.Patrol || self.npc_state == NPCState.Idle) else patrol_last_location
	switch_npc_state(NPCState.Chase)

func _on_chase_body_exited(body):
	current_player = null
	switch_npc_state(NPCState.Return)

func _on_InteractionArea2D_area_entered(area):
	is_inside = true
	match self.npc_type:
		NPCType.Friendly:
			interact_icon_tweener.stop_all()
			interact_icon_tweener.interpolate_property($InteractionIcon, 'position:y', $InteractionIcon.position.y, interact_position_x - interaction_offset, interaction_anim_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			interact_icon_tweener.interpolate_property($InteractionIcon, 'scale:x', $InteractionIcon.scale.x, interact_scale_x, interaction_anim_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			interact_icon_tweener.interpolate_property($InteractionIcon, 'modulate:a', $InteractionIcon.modulate.a, 1, interaction_anim_speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
			interact_icon_tweener.start()
		NPCType.Hostile:
			get_node('/root/LevelManager').initiate_combat(self)


func _on_InteractionArea2D_area_exited(area):
	is_inside = false
	match self.npc_type:
		NPCType.Friendly:
			interact_icon_tweener.stop_all()
			interact_icon_tweener.interpolate_property($InteractionIcon, 'position:y', $InteractionIcon.position.y, interact_position_x, interaction_anim_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			interact_icon_tweener.interpolate_property($InteractionIcon, 'scale:x', $InteractionIcon.scale.x, 0, interaction_anim_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			interact_icon_tweener.interpolate_property($InteractionIcon, 'modulate:a', $InteractionIcon.modulate.a, 0, interaction_anim_speed, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			interact_icon_tweener.start()
		
	
