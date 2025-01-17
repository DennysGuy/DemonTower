extends State

@export_category("States")
@export
var idle_state: State
@export
var move_state: State
@export
var climb_state: State
@export
var jump_state: State
@export
var hit_state: State
@export_category("Detectors")
@export
var ladder_detector: RayCast2D

@onready
var timer: Timer = $"../../Timer"

func enter() -> void:
	parent.enable_gravity = true
	#animation_name = PlayerManager.get_player_color()+"_Fall"
	parent.set_textures(name)
	parent.play_animation(6)
	super()
	timer.start()

func exit() -> void:
	parent.has_jumped = false

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	var movement = Input.get_axis("move_left", "move_right") * move_speed
	if movement != 0:
		#parent.animation_player.flip_h = movement < 0
		parent.flip_textures(movement < 0)
	
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if Input.is_action_just_pressed("move_up") and parent.in_ladder_area or Input.is_action_pressed("move_down") and ladder_detector.is_colliding():
		return climb_state
	
	if !timer.is_stopped():
		if Input.is_action_just_pressed("jump") and parent.has_jumped == false:
			parent.jump_force = 350
			
			return jump_state
	
	if parent.was_hit:
		return hit_state
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		else:
			return idle_state
	
	return null
			
