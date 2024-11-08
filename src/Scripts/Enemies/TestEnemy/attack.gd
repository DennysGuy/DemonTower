extends State

@export
var pursue_state : State
@onready
var timer = $"../../Timer"
@onready
var velocity_component = $"../../VelocityComponent"
@onready
var direction_comparator = $"../../DirectionComparator"
@onready
var no_zone_detector = $"../../NoZoneDetector"


func enter() -> void:
	print("I'm in attack state")
	super()

func process_physics(_delta: float) -> State:
	if !parent.can_attack:
		return pursue_state

	return null
