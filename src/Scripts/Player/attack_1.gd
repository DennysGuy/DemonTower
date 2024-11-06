extends State

@export
var idle_state: State
@export
var attack2_state: State
@onready
var timer := $"../../Timer"
@onready
var animation : AnimatedSprite2D = $"../../animations"
func enter() -> void:
	animation_name = "Green_Attack1"
	timer.wait_time = 0.50
	timer.start()
	super()


func exit() -> void:
	timer.stop()
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	if timer.time_left <= 0:
		if Input.is_action_pressed("attack"):
			return attack2_state
		return idle_state
	return null
