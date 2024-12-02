extends Node
class_name HealthComponent

@onready var damage_taken_label : Label = $"../DamageTaken"
# Called when the node enters the scene tree for the first time
@export var parent : Entity

func apply_healing(health: float):
	parent.stats_resource.current_health = min(parent.stats_resource.max_health, parent.stats_resource.current_health + health)

func apply_mp_replenish(magic_points : float):
	parent.stats_resource.current_magic_points = min(parent.stats_resource.magic_points, parent.stats_resource.current_magic_points + magic_points)

func apply_damage(stats_resource : Stats, equipped_weapon : Weapon):
	var hit_chance = max(0.1, min(0.98,stats_resource.accuracy / (stats_resource.accuracy + parent.stats_resource.avoidability)))*100
	var hit_roll = randi_range(1,100)
	if hit_roll <= hit_chance:
		#hit landed
		var incoming_damage : int 
		incoming_damage = select_weapon_damage_type(stats_resource, equipped_weapon)
		#need to calculate crit rate 
		var crit_roll = randi_range(1,100)
		var crit_chance = int(100*stats_resource.critical_rate) #if crit
		if crit_roll <= crit_chance:
			incoming_damage *= stats_resource.critical_damage
			parent.stats_resource.current_health -= incoming_damage
			damage_taken_label.text = "CRIT:"+str(incoming_damage)
		else:
			parent.stats_resource.current_health -= incoming_damage
			damage_taken_label.text = str(incoming_damage)
			
		if parent.stats_resource.current_health < 0:
			parent.stats_resource.current_health = 0
	else:
		damage_taken_label.text = "MISSED!"
		pass
	
	

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
