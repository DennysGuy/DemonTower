extends State

@export
var idle_state : State
@export
var attack_state : State

@onready
var timer = $"../../Timer"
@onready
var velocity_component = $"../../VelocityComponent"
@onready
var direction_comparator = $"../../DirectionComparator"
@onready
var no_zone_detector = $"../../NoZoneDetector"
@onready
var animations : AnimatedSprite2D = $"../../animations"
@export
var stop_distance : int

func enter() -> void:
	print("I'm in pursue state")
	velocity_component.move_speed = 100
	super()

func process_frame(_delta: float) -> State:
	if !self.parent.player_seen and timer.time_left == 0:
			return idle_state
	return null

func process_physics(_delta: float) -> State:
	if parent.can_attack:
		return attack_state
	else:
		self.parent.velocity.y += gravity * _delta
		
		var dir_vector = (self.parent.player.global_position - self.parent.global_position).normalized()
		var direction = GameManager.set_direction(dir_vector.x)
		var distance_to_player = self.parent.global_position.distance_to(self.parent.player.global_position)
		parent.animation_player.flip_h = direction > 0
		velocity_component.apply_horizontal_movement(direction)
		self.parent.set_floor_snap_length(30)
		self.parent.apply_floor_snap()
		self.parent.move_and_slide()
		
		

			
	


	
	return null
