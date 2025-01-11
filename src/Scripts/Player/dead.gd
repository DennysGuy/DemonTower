extends State


func enter() -> void:
	animation_name = PlayerManager.get_player_color()+"_Die"
	parent.set_textures(name)
	parent.play_animation(3)
	parent.enable_gravity = true
	super()

func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
