extends State

@export
var idle_state: State
@export
var dead_state: State
@export
var pursue_state: State
@onready
var timer := $"../../Timer"
@onready
var animation : AnimatedSprite2D = $"../../animations"
@onready
var health_component : HealthComponent = $"../../HealthComponent"
@onready
var stats_component : StatsComponent = $"../../StatsComponent"
@onready
var player : Entity = $"../.."
func enter() -> void:
	parent.enable_gravity = true
	timer.wait_time = 0.30
	timer.start()
	super()


func exit() -> void:
	timer.stop()
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	var direction_vector = (parent.global_position - parent.enemy_hitbox_parent.global_position).normalized()
	var direction = GameManager.set_direction(direction_vector.x)
	
	if stats_component.get_current_health() <= 0:
		return dead_state
	if timer.time_left <= 0:
		return pursue_state

	return null
