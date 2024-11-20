extends State
@onready
var stat_component : StatsComponent = $"../../StatsComponent"
@onready
var item_holder : ItemHolder = $"../../ItemHolder"

func enter() -> void:
	parent.enable_gravity = true
	super()
	parent.player.apply_received_xp(parent.stats_resource.xp_value)
	
	parent.spawn_currency()
	parent.spawn_item()
	print("IM DEAD!")
	parent.call_deferred("queue_free")

func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
