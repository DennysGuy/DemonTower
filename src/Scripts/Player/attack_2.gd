extends State

@export
var idle_state: State
@export
var attack3_state: State
@export
var hit_state: State
@onready
var timer := $"../../Timer"
@onready
var animation : AnimatedSprite2D = $"../../animations"
@onready
var hitbox_collision : CollisionShape2D = $"../../HitBox/CollisionShape2D"

func enter() -> void:
	parent.enable_gravity = true
	animation_name = GameManager.selected_color+"_Attack2"
	timer.wait_time = 0.2
	timer.start()
	super()


func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:

	return null

func process_physics(_delta: float) -> State:
	
	if animation.frame == 1:
		hitbox_collision.disabled = false
	else:
		hitbox_collision.disabled = true
	
	if timer.time_left <= 0: 
		if Input.is_action_pressed("attack"):
			return attack3_state
		return idle_state
		
	
	return null
