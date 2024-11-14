extends State

@export
var idle_state : State
@export
var attack_state : State
@export
var hit_state : State

@onready
var timer = $"../../Timer"
@onready
var velocity_component = $"../../VelocityComponent"
@onready
var direction_comparator = $"../../DirectionComparator"
@onready
var no_zone_detector = $"../../NoZoneDetector"
@onready
var hit_box : Area2D = $"../../HitBoxComponent"
@onready
var animations : AnimatedSprite2D = $"../../animations"
@export
var stop_distance : int

func enter() -> void:
	parent.enable_gravity = true
	parent.was_hit = false
	velocity_component.move_speed = 100
	super()

func process_frame(_delta: float) -> State:

	print_debug(parent.player_seen)
	if !self.parent.player_seen and timer.time_left == 0:
			return idle_state
	return null

func process_physics(_delta: float) -> State:
	if parent.was_hit:
		return hit_state
	if parent.can_attack:
		return attack_state
	else:
		self.parent.velocity.y += gravity * _delta
		var dir_vector = (self.parent.player.global_position - self.parent.global_position).normalized()
		var direction = GameManager.set_direction(dir_vector.x)
		var distance_to_player = self.parent.global_position.distance_to(self.parent.player.global_position)
		parent.animation_player.flip_h = direction > 0
		velocity_component.apply_horizontal_movement(direction, parent)
		hit_box.position.x = parent.hit_box_x_pos * direction
		parent.move_and_slide()
		
	return null
