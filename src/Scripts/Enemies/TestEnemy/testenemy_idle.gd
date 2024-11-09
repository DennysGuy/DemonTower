extends State

@export
var patrol_state : State
@export
var pursue_state : State
@export
var hit_state : State
@onready
var timer = $"../../Timer"

@onready
var VelocityComp = $"../../VelocityComponent"
@onready
var direction_comparator = $"../../DirectionComparator"
@onready
var no_zone_detector = $"../../NoZoneDetector"
@onready
var hitbox_collision : CollisionShape2D = $"../../HitBoxComponent/CollisionShape2D"


func enter() -> void:
	parent.was_hit = false
	parent.enable_gravity = true
	print("I'm in idle state")
	super()
	hitbox_collision.disabled = true
	var dir = direction_comparator.target_position.x
	if no_zone_detector.is_colliding() and no_zone_detector.target_position.x == dir:
		direction_comparator.target_position.x = dir * -1
	
	timer.wait_time = 3.0
	VelocityComp.set_move_speed(0)
	timer.start()

func process_physics(_delta: float) -> State:
	self.parent.velocity.y += gravity * _delta
	VelocityComp.apply_horizontal_movement(1, parent)
	if parent.was_hit:
		return hit_state
	if parent.player_seen:
		return pursue_state
	if timer.time_left == 0:
		return patrol_state
	
	return null
