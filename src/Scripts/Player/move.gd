extends State

@export
var idle_state: State
@export
var jump_state: State
@export
var fall_state: State
@export
var hit_state: State
@export
var climb_state: State

var prev_input

func enter() -> void:
	parent.was_hit = false
	parent.enable_gravity = true
	animation_name = GameManager.selected_color+"_Run"
	super()
	parent.jump_force = 250
	parent.velocity.x = 0

func exit() -> void:
	parent.velocity.x = 0

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	if Input.is_action_just_pressed("move_up") and parent.in_ladder_area:
		return climb_state
	
	return null

func process_physics(_delta: float) -> State:
	var input = Input.get_axis("move_left","move_right")
	if input != 0:
		prev_input = input
	var movement = input * move_speed

	parent.hitbox.position.x = (parent.hit_box_x_pos * input)
	print(parent.hitbox.position.x)
	if movement != 0:
		parent.animation_player.flip_h = movement < 0
	
	parent.velocity.x = movement
	#set floor snapping for sloped surfaces
	parent.set_floor_snap_length(30)
	parent.apply_floor_snap()
	parent.move_and_slide()
	
	if parent.was_hit:
		return hit_state
	
	if  movement == 0:
		parent.hitbox.position.x = (parent.hit_box_x_pos * prev_input)
		return idle_state
	
	if !parent.is_on_floor():
		return fall_state
	
	return null
