extends State

@export
var pursue_state : State
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
var attack_animation = $"../../animations"
@onready
var hitbox_collision : CollisionShape2D = $"../../HitBoxComponent/CollisionShape2D"
@onready
var hit_box : Area2D = $"../../HitBoxComponent"

func enter() -> void:
	print("I'm in attack state")
	parent.enable_gravity = true
	parent.was_hit = false
	super()

func process_physics(_delta: float) -> State:
	var dir_vector = (self.parent.player.global_position - self.parent.global_position).normalized()
	var direction = GameManager.set_direction(dir_vector.x)
	hit_box.position.x = parent.hit_box_x_pos * direction
	if parent.was_hit:
		return hit_state
	
	if attack_animation.frame == 5:
		hitbox_collision.disabled = false
	else:
		hitbox_collision.disabled = true
	

	
	if !parent.can_attack:
		return pursue_state

	return null
