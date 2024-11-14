extends State

@export
var fall_state: State
@export
var move_state: State
@export
var idle_state: State
@export
var climb_state: State
@export
var hit_state: State

func enter() -> void:
	parent.enable_gravity = true
	animation_name = GameManager.get_player_color()+"_Jump"
	super()
	parent.has_jumped = true
	parent.velocity.y -= 300

func process_input(_event: InputEvent) -> State:
		
	if Input.is_action_just_pressed("move_up") and parent.in_ladder_area:
		return climb_state
	
	return null

func process_physics(_delta: float) -> State:
	if parent.velocity.y > 0:
		return fall_state
	
	var movement = Input.get_axis("move_left","move_right") * move_speed
	if movement != 0:
		parent.animation_player.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.was_hit:
		return hit_state
	
	if parent.is_on_floor():
		return idle_state
	
	return null
