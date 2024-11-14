extends State

@export
var jump_state: State
@export
var fall_state: State
@export
var move_state: State
@export
var climb_state: State
@export
var attack_state: State
@export
var hit_state: State

@export
var ladder_detector: RayCast2D
@onready
var velocity_component : VelocityComponent = $"../../VelocityComponent"
func enter() -> void:
	velocity_component.set_move_speed(0)
	parent.was_hit = false
	parent.enable_gravity = true
	parent.hitbox_collision.disabled = true
	animation_name = GameManager.get_player_color()+"_Idle"
	super()
	parent.jump_force = 300

func process_input(_event: InputEvent) -> State:
	
	var key_pressed: bool = _event.is_action_pressed("move_left") or _event.is_action_pressed("move_right")
	
	if key_pressed and parent.is_on_floor():
		return move_state
	
	if Input.is_action_just_pressed("jump"):
		return jump_state
	
	if Input.is_action_just_pressed("attack"):
		return attack_state
	
	return null

func process_physics(_delta: float) -> State:
	var movement = Input.get_axis("move_left","move_right")
	#checks the input while idle state for being pressed; if pressed return to move state

	if Input.is_action_pressed("move_up") and parent.in_ladder_area or Input.is_action_pressed("move_down") and ladder_detector.is_colliding():
		return climb_state

	if parent.was_hit:
		return hit_state

	if movement != 0 and parent.is_on_floor():
		return move_state
	
	#parent.velocity.x = 0
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	
	return null
