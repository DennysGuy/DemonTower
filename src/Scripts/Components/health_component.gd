extends Node
class_name HealthComponent

@onready var stats_component : StatsComponent = $"../StatsComponent"
@onready var damage_taken_label : Label = $"../DamageTaken"
# Called when the node enters the scene tree for the first time
@export var parent : Entity

func apply_healing(health: float):
	if stats_component.get_current_health() + health > stats_component.get_max_health():
		stats_component.set_current_health(stats_component.get_max_health())
		if get_parent().name == "Player":
			PlayerManager.set_player_current_health(stats_component.get_max_health())
	else:
		stats_component.set_current_health(stats_component.get_current_health()+health)
		if get_parent().name == "Player":
			PlayerManager.set_player_current_health(stats_component.get_current_health()+health)

func apply_damage(stats_resource : Stats, equipped_weapon : Weapon):
	var incoming_damage : int 
	incoming_damage = select_weapon_damage_type(stats_resource, equipped_weapon)
	damage_taken_label.text = str(incoming_damage)
	parent.stats_resource.current_health -= incoming_damage
	if stats_resource.current_health < 0:
		stats_resource.current_health = 0

func select_weapon_damage_type(stats_resource : Stats, equipped_weapon : Weapon) -> int:
	match(equipped_weapon.get_archetype_class_name()):
		"Warrior":
			return randi_range(stats_resource.get_min_weapon_attack(), stats_resource.get_max_weapon_attack()) * (1-stats_resource.get_true_weapon_defense())
		"Mage":
			return randi_range(stats_resource.get_min_magic_attack(), stats_resource.get_max_magic_attack()) * (1-stats_resource.get_true_magic_defense())
		"Rogue":
			return randi_range(stats_resource.get_min_shadow_attack(), stats_resource.get_max_shadow_attack())
		_:
			return 0	
