extends State
@onready
var stat_component : StatsComponent = $"../../StatsComponent"
func enter() -> void:
	parent.enable_gravity = true
	parent.player.apply_received_xp(parent.stats_resource.xp_value)
	super()

func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
