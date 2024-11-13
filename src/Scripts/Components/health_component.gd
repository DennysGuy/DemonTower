extends Node
class_name HealthComponent


@onready var stats_component : StatsComponent = $"../StatsComponent"
@onready var damage_taken_label : Label = $"../DamageTaken"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func apply_damage(min_damage : int, max_damage : int):
	var incoming_damage = randi_range(min_damage, max_damage) * (1-stats_component.get_weapon_defense())
	damage_taken_label.text = str(incoming_damage)
	stats_component.set_current_health(stats_component.get_current_health()-int(incoming_damage)) 
	if stats_component.get_current_health() <= 0:
		stats_component.set_current_health(0)
	if get_parent().name == "Player":
		GameManager.set_player_current_health(stats_component.get_current_health())

func apply_healing(health: float):
	if stats_component.get_current_health() + health > stats_component.get_max_health():
		stats_component.set_current_health(stats_component.get_max_health())
		if get_parent().name == "Player":
			GameManager.set_player_current_health(stats_component.get_max_health())
	else:
		stats_component.set_current_health(stats_component.get_current_health()+health)
		if get_parent().name == "Player":
			GameManager.set_player_current_health(stats_component.get_current_health()+health)
