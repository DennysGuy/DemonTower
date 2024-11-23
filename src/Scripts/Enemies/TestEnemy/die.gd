extends State
@onready
var stat_component : StatsComponent = $"../../StatsComponent"
@onready
var item_holder : ItemHolder = $"../../ItemHolder"

func enter() -> void:
	parent.enable_gravity = true
	super()
	parent.player.apply_received_xp(parent.stats_resource.xp_value)
	
	item_holder.spawn_currency()
	item_holder.spawn_items()
	print("IM DEAD!")
	parent.call_deferred("queue_free")

func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
