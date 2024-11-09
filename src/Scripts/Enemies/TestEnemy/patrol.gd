extends State

@export
var idle_state : State
@export
var pursue_state : State
@export
var hit_state : State

@onready
var timer = $"../../Timer"
@onready
var velocity_component : Node = $"../../VelocityComponent"
@onready
var hit_box : Area2D = $"../../HitBoxComponent"

@export
var no_zone_detector : RayCast2D
@export
var direction_compartor : RayCast2D
@export
var ray_cast_length : int

var directions : Array = [-1, 1]
var dir : int
func enter() -> void:
	super()
	parent.was_hit = false
	parent.enable_gravity = true
	velocity_component.move_speed = 50
	timer.wait_time = randi_range(2,5)
	
	if parent.animation_player.flip_h and no_zone_detector.is_colliding():
		dir = -1
	elif !parent.animation_player.flip_h and no_zone_detector.is_colliding():
		dir = 1
	else:
		dir = directions.pick_random()
	timer.start()
	print("I'm in patrol state")
	print_debug(velocity_component.move_speed)

func process_physics(_delta: float) -> State:
	self.parent.velocity.y += gravity * _delta
	
	velocity_component.apply_horizontal_movement(dir, parent)
	
	if no_zone_detector.is_colliding() and int(direction_compartor.target_position.x) == int(no_zone_detector.target_position.x) :
		direction_compartor.target_position.x = (dir * ray_cast_length) * -1
		return idle_state
	
	parent.animation_player.flip_h = dir > 0
	

	no_zone_detector.target_position.x = (ray_cast_length * dir)
	direction_compartor.target_position.x = (ray_cast_length * dir)
	hit_box.position.x = (parent.hit_box_x_pos * dir)
	
	self.parent.move_and_slide()
	
	if parent.was_hit:
		return hit_state
	
	if parent.player_seen:
		return pursue_state
	
	if timer.time_left == 0:
		return idle_state
	

	
	return null
