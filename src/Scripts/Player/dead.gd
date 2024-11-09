extends State


func enter() -> void:
	animation_name = GameManager.selected_color+"_Die"
	parent.enable_gravity = true
	super()

func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
