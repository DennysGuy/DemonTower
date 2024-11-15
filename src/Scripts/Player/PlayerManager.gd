extends Node

const BASE_JUMP_FORCE = 200
const BASE_MOVEMENT_SPEED = 120
const BASE_WEAPON_ATTACK = 10
const BASE_MAGIC_ATTACK = 10
const BASE_WEAPON_DEFENSE = 5
const BASE_MAGIC_DEFENSE = 5
const BASE_CRIT_RATE = 0
const BASE_CRIT_DAMAGE = 5
const BASE_ACCURACY = 10
const BASE_AVOIDABILITY = 10
enum ArchetypeClass {
	WARRIOR,
	MAGE,
	ROGUE
}
enum WeaponClass {
	SWORDSHIELD,
	SPEAR,
	TWOHANDED,
	WAND,
	STAFF,
	KNIVES,
	CLAW
}

var equipped_weapon = {
	"name": "Wooden Sword and Shield",
	"archetype_class": ArchetypeClass.WARRIOR,
	"weapon_class": WeaponClass.SWORDSHIELD,
	"weapon_attack": 10,
	"weapon_defense": 5,
	"magic_attack": 0,
	"magic_defense": 0,
	"HP_Bonus": 0,
	"MP_Bonus": 0,
	"movement_speed_bonus": 0,
	"jump_bonus": 0,
	"animation_name": "",
	"inventory_icon": "",
	"drop_icon": "",
}
var selected_player = {
	"name": "",
	"color": "",
	"max_health": 100.0, #for setting initial health
	"current_health": 100.0, #keeping track of current health
	"magic_points": 100,
	"current_magic_points": 100,
	"total_level": 1, #total level of all stats
	"total_xp_attained": 0,
	"str_level": 1,
	"dex_level": 1,
	"int_level": 1,
	"luk_level": 1,
	"str_needed_xp": 0,
	"dex_needed_xp": 0,
	"int_needed_xp": 0,
	"luk_needed_xp": 0,
	"str_current_xp": 0,
	"dex_current_xp": 0,
	"int_current_xp": 0,
	"luk_current_xp": 0,
	"min_weapon_attack": 0,
	"max_weapon_attack": 0,
	"min_magic_attack": 0,
	"max_magic_attack": 0,
	"critical_rate": 0,
	"critical_damage": 0,
	"avoidability": BASE_AVOIDABILITY,
	"accuracy": BASE_ACCURACY,
	"xp_rate": 1,
	"speed": BASE_MOVEMENT_SPEED,
	"jump": BASE_JUMP_FORCE
}
# Setter and getter functions for each dictionary element in selected_player

# Name
func set_player_name(name: String) -> void:
	selected_player["name"] = name

func get_player_name() -> String:
	return selected_player["name"]

# Color
func set_player_color(color: String) -> void:
	selected_player["color"] = color

func get_player_color() -> String:
	return selected_player["color"]

# Max Health
func set_player_max_health(max_health: float) -> void:
	selected_player["max_health"] = max_health

func get_player_max_health() -> float:
	return selected_player["max_health"]

func set_player_minimum_weapon_attack(value : int) -> void:
	selected_player["min_weapon_attack"] = value

func get_player_minimum_weapon_attack() -> int:
	return selected_player["min_weapon_attack"]

func set_player_maximum_weapon_attack(value : int) -> void:
	selected_player["max_weapon_attack"] = value

func get_player_maximum_weapon_attack() -> int:
	return selected_player["max_weapon_attack"]
	
func set_player_minimum_magic_attack(value : int) -> void:
	selected_player["min_magic_attack"] = value

func get_player_minimum_magic_attack() -> int:
	return selected_player["min_magic_attack"]

func set_player_maximum_magic_attack(value : int) -> void:
	selected_player["max_magic_attack"] = value

func get_player_maximum_magic_attack() -> int:
	return selected_player["max_magic_attack"]

# Current Health
func set_player_current_health(current_health: float) -> void:
	selected_player["current_health"] = current_health

func get_player_current_health() -> float:
	return selected_player["current_health"]

# Magic Points
func set_player_magic_points(magic_points: int) -> void:
	selected_player["magic_points"] = magic_points

func get_player_magic_points() -> int:
	return selected_player["magic_points"]

# Current Magic Points
func set_player_current_magic_points(current_magic_points: int) -> void:
	selected_player["current_magic_points"] = current_magic_points

func get_player_current_magic_points() -> int:
	return selected_player["current_magic_points"]

# Current Level
func set_player_total_level() -> void:
	var str_level = selected_player["str_level"]
	var dex_level = selected_player["dex_level"]
	var int_level = selected_player["int_level"]
	var luk_level = selected_player["luk_level"]
	selected_player["total_level"] = str_level + dex_level + int_level + luk_level

func get_player_total_level() -> int:
	return selected_player["total_level"]

#Stats XP Needed
#Setters
func set_player_str_xp_needed(value : int) -> void:
	selected_player["str_needed_xp"] = value

func set_player_dex_xp_needed(value : int) -> void:
	selected_player["dex_needed_xp"] = value

func set_player_int_xp_needed(value : int) -> void:
	selected_player["int_needed_xp"] = value

func set_player_luk_xp_needed(value : int) -> void:
	selected_player["luk_needed_xp"] = value
#Getters
func get_player_str_xp_needed() -> int:
	return selected_player["str_needed_xp"]
	
func get_player_dex_xp_needed() -> int:
	return selected_player["dex_needed_xp"]

func get_player_int_xp_needed() -> int:
	return selected_player["int_needed_xp"]

func get_player_luk_xp_needed() -> int:
	return selected_player["luk_needed_xp"]

#Stats Current XP
#Setters
func set_player_str_current_xp(value : int) -> void:
	selected_player["str_current_xp"] = value

func set_player_dex_current_xp(value : int) -> void:
	selected_player["dex_current_xp"] = value

func set_player_int_current_xp(value : int) -> void:
	selected_player["int_current_xp"] = value

func set_player_luk_current_xp(value : int) -> void:
	selected_player["luk_current_xp"] = value
#Getters
func get_player_str_current_xp() -> int:
	return selected_player["str_current_xp"]

func get_player_dex_current_xp() -> int:
	return selected_player["dex_current_xp"]

func get_player_int_current_xp() -> int:
	return selected_player["int_current_xp"]

func get_player_luk_current_xp() -> int:
	return selected_player["luk_current_xp"]

# Strength
func set_player_strength(strength: int) -> void:
	selected_player["str_level"] = strength

func get_player_current_strength_level() -> int:
	return selected_player["str_level"]

# Dexterity
func set_player_current_dexterity_level(dexterity: int) -> void:
	selected_player["dex_level"] = dexterity

func get_player_current_dexterity_level() -> int:
	return selected_player["dex_level"]

# Intelligence
func set_player_current_intelligence_level(intelligence: int) -> void:
	selected_player["int_level"] = intelligence

func get_player_current_intelligence_level() -> int:
	return selected_player["int_level"]

# Luck
func set_player_current_luck_level(luck: int) -> void:
	selected_player["luk_level"] = luck

func get_player_current_luck_level() -> int:
	return selected_player["luk_level"]

# Critical Rate
func set_player_critical_rate(critical_rate: int) -> void:
	selected_player["critical_rate"] = critical_rate

func get_player_critical_rate() -> int:
	return selected_player["critical_rate"]

# Critical Damage
func set_player_critical_damage(critical_damage: int) -> void:
	selected_player["critical_damage"] = critical_damage

func get_player_critical_damage() -> int:
	return selected_player["critical_damage"]

# XP Rate
func set_player_xp_rate(xp_rate: int) -> void:
	selected_player["xp_rate"] = xp_rate

func get_player_xp_rate() -> int:
	return selected_player["xp_rate"]

# Drop Rate
func set_player_drop_rate(drop_rate: int) -> void:
	selected_player["drop_rate"] = drop_rate

func get_player_drop_rate() -> int:
	return selected_player["drop_rate"]

# Speed
func set_player_speed(speed: int) -> void:
	selected_player["speed"] = speed

func get_player_speed() -> int:
	return selected_player["speed"]

# Jump
func set_player_jump(jump: int) -> void:
	selected_player["jump"] = jump

func get_player_jump() -> int:
	return selected_player["jump"]

# Getters
func get_weapon_name() -> String:
	return equipped_weapon["name"]

func get_weapon_archetype_class() -> int:
	return equipped_weapon["archetype_class"]

func get_weapon_class() -> int:
	return equipped_weapon["weapon_class"]

func get_weapon_attack() -> int:
	return equipped_weapon["weapon_attack"]

func get_weapon_defense() -> int:
	return equipped_weapon["weapon_defense"]

func get_weapon_magic_attack() -> int:
	return equipped_weapon["magic_attack"]

func get_weapon_magic_defense() -> int:
	return equipped_weapon["magic_defense"]

func get_weapon_HP_bonus() -> int:
	return equipped_weapon["HP_Bonus"]

func get_weapon_MP_bonus() -> int:
	return equipped_weapon["MP_Bonus"]

func get_movement_speed_bonus() -> int:
	return equipped_weapon["movement_speed_bonus"]

func get_jump_bonus() -> int:
	return equipped_weapon["jump_bonus"]

# Setters
func set_weapon_name(new_name: String) -> void:
	equipped_weapon["name"] = new_name

func set_weapon_archetype_class(new_archetype_class: ArchetypeClass) -> void:
	equipped_weapon["archetype_class"] = new_archetype_class

func set_weapon_class(new_weapon_class: WeaponClass) -> void:
	equipped_weapon["weapon_class"] = new_weapon_class

func set_weapon_attack(new_weapon_attack: int) -> void:
	equipped_weapon["weapon_attack"] = new_weapon_attack

func set_weapon_defense(new_weapon_defense: int) -> void:
	equipped_weapon["weapon_defense"] = new_weapon_defense

func set_weapon_magic_attack(new_magic_attack: int) -> void:
	equipped_weapon["magic_attack"] = new_magic_attack

func set_weapon_magic_defense(new_magic_defense: int) -> void:
	equipped_weapon["magic_defense"] = new_magic_defense

func set_weapon_HP_bonus(new_HP_bonus: int) -> void:
	equipped_weapon["HP_Bonus"] = new_HP_bonus

func set_weapon_MP_bonus(new_MP_bonus: int) -> void:
	equipped_weapon["MP_Bonus"] = new_MP_bonus

func set_movement_speed_bonus(new_movement_speed_bonus: int) -> void:
	equipped_weapon["movement_speed_bonus"] = new_movement_speed_bonus

func set_jump_bonus(new_jump_bonus: int) -> void:
	equipped_weapon["jump_bonus"] = new_jump_bonus

func get_archetype_name() -> String:
	var archetype_name :String
	match(equipped_weapon["archetype_class"]):
		ArchetypeClass.WARRIOR:
			archetype_name = "Warrior"
		ArchetypeClass.MAGE:
			archetype_name = "Mage"
		ArchetypeClass.ROGUE:
			archetype_name = "Rogue"
	return archetype_name

func get_relevant_attribute_stat() -> Array[int]:
	var stats : Array[int] = [0,0]
	match(get_weapon_archetype_class()):
		ArchetypeClass.WARRIOR:
			stats = [get_player_current_strength_level(), 0]
		ArchetypeClass.MAGE:
			stats = [get_player_current_intelligence_level(), 0]
		ArchetypeClass.ROGUE:
			if get_weapon_class() == WeaponClass.KNIVES:
				stats = [get_player_current_luck_level(), get_player_current_dexterity_level()]
			else:
				stats = [get_player_current_luck_level(), get_player_current_dexterity_level()]
	return stats

# Declare the variables
var _player_true_weapon_defense: int
var _player_true_magic_defense: int

# Setter and Getter for _player_true_weapon_defense
func set_player_true_weapon_defense(value: int) -> void:
	_player_true_weapon_defense = value

func get_player_true_weapon_defense() -> int:
	return _player_true_weapon_defense

# Setter and Getter for _player_true_magic_defense
func set_player_true_magic_defense(value: int) -> void:
	_player_true_magic_defense = value

func get_player_true_magic_defense() -> int:
	return _player_true_magic_defense

func calculate_player_minimum_weapon_attack_damage(primary_stat : int, secondary_stat : int, weapon_attack : int):
	var value = int(((primary_stat+secondary_stat/100) * weapon_attack))*0.8
	set_player_minimum_weapon_attack(value)

func calculate_player_maximum_weapon_attack_damage(primary_stat : int, secondary_stat : int, weapon_attack : int):
	var value = int(((primary_stat+secondary_stat/100) * weapon_attack))
	set_player_maximum_weapon_attack(value)
func calculate_player_minimum_magic_attack_damage(magic_attack : int) -> void:
	var int_level = get_player_current_intelligence_level()
	var value = int(((int_level/100) * magic_attack) * 0.8)
	set_player_minimum_magic_attack(value)
func calculate_player_maximum_magic_attack_damage(magic_attack : int) -> void:
	var int_level = get_player_current_intelligence_level()
	var value = int((int_level/100) * magic_attack)
	set_player_maximum_magic_attack(value)
	
func calculate_needed_stat_xp(stat_level : String, stat_needed_xp : String) -> void:
	var next_level = selected_player[stat_level]+1
	var required_xp = int(pow(next_level, 1.8) + next_level * 4)
	selected_player[stat_needed_xp] = required_xp

func calculate_weapon_defense() -> void:
	var value = int(get_weapon_defense()/(get_weapon_defense() + (100 * get_player_current_strength_level())))
	set_player_true_weapon_defense(value)
func calculate_magic_defense() -> void:
	var value = int(get_weapon_magic_defense()/(get_weapon_magic_defense() + (100 * get_player_current_intelligence_level())))
	set_player_true_magic_defense(value)
	
func level_up_stat(stat : String, current_stat_xp : String, needed_stat_xp : String):
		var roll_over_xp = selected_player[current_stat_xp] - selected_player[needed_stat_xp]
		if selected_player[current_stat_xp] >= selected_player[needed_stat_xp]: 
			selected_player[stat] += 1
			if roll_over_xp > 0:
				selected_player[current_stat_xp] = roll_over_xp
			else:
				selected_player[current_stat_xp] = 0
			calculate_needed_stat_xp(stat, needed_stat_xp)

func track_for_excess_xp():
	level_up_stat("str_level", "str_current_xp", "str_needed_xp")
	level_up_stat("dex_level", "dex_current_xp", "dex_needed_xp")
	level_up_stat("int_level", "int_current_xp", "int_needed_xp")
	level_up_stat("luk_level", "luk_current_xp", "luk_needed_xp")
	set_player_total_level()
	
func set_up_min_max_attack():
	var relevant_attributes = get_relevant_attribute_stat()
	match(get_weapon_archetype_class()):
		ArchetypeClass.WARRIOR:
			print_debug("IM HEAR!")
			calculate_player_minimum_weapon_attack_damage(get_player_current_strength_level(),0,get_weapon_attack())
			calculate_player_maximum_weapon_attack_damage(get_player_current_strength_level(),0,get_weapon_attack())
		ArchetypeClass.ROGUE:
			calculate_player_minimum_weapon_attack_damage(get_player_current_luck_level(),get_player_current_dexterity_level(),get_weapon_attack())
			calculate_player_maximum_weapon_attack_damage(get_player_current_luck_level(),get_player_current_dexterity_level(),get_weapon_attack())
		ArchetypeClass.MAGE:
			calculate_player_minimum_magic_attack_damage(get_weapon_magic_attack())
			calculate_player_maximum_magic_attack_damage(get_weapon_magic_attack())
