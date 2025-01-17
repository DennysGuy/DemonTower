extends State

@export
var idle_state: State
@export
var dead_state : State
@onready
var timer := $"../../Timer"
@onready
var animation : AnimatedSprite2D = $"../../animations"
@onready
var health_component : HealthComponent = $"../../HealthComponent"

@onready
var player : Player = $"../.."

func enter() -> void:
	animation_name = PlayerManager.get_player_color()+"_Hit"
	parent.set_textures(name)
	parent.play_animation(2)
	timer.wait_time = 0.30
	timer.start()
	super()


func exit() -> void:
	timer.stop()
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	var direction_vector = (parent.global_position - parent.enemy.global_position).normalized()
	var direction = GameManager.set_direction(direction_vector.x)
	
	if player.stats_resource.current_health <= 0:
		return dead_state
	if timer.time_left <= 0:
		return idle_state
	
		
	return null
