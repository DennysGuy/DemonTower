extends State

@export
var idle_state: State
@export
var attack1_state: State
@onready
var timer := $"../../Timer"
func enter() -> void:
	animation_name = "Green_Attack3"
	move_speed = 10
	super()
	timer.wait_time = 0.5
	timer.start()

func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:

	return null

func process_physics(_delta: float) -> State:

	if timer.time_left == 0: 
		if Input.is_action_pressed("attack"):
			return attack1_state
		else:
			return idle_state
	
	return null
