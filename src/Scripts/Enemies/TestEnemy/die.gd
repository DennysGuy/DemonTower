extends State


func enter() -> void:
	parent.enable_gravity = true
	super()

func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null