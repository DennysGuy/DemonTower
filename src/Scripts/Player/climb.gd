extends State

@export
var idle_state: State
@export
var jump_state: State
@export
var fall_state: State
@export
var hit_state: State
func enter() -> void:
	super()
	parent.enable_gravity = false
	animation_name = GameManager.get_color()+"_Climb"
	parent.velocity.x = 0
	move_speed = 100
	

func exit() -> void:
	pass
func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	return null

func process_physics(_delta: float) -> State:
	var input = Input.get_axis("move_up","move_down")
	var movement = input * move_speed

	parent.velocity.y = movement

	parent.move_and_slide()
	
	if input == 0:
		parent.animation_player.stop()
	else:
		parent.animation_player.play()
	
	if parent.was_hit:
		return hit_state
	
	if parent.is_on_floor():
		return idle_state
	
	if !parent.in_ladder_area and !parent.is_on_floor():
		return fall_state
	
	
	return null
