extends Node

#base constants
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

var players = {}
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

func set_direction(dir_vector : float):
	if (dir_vector < 0):
		return -1
	else:
		return 1

func set_player_hitbox_direction(dir_vector : float):
	if (dir_vector == 0):
		return 1
	else:
		return -1

func apply_gravity(entity : Entity, gravity, delta):
	entity.velocity.y += gravity * delta

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

# Player Class
func set_player_class(new_class: String) -> void:
	selected_player["class"] = new_class

func get_player_class() -> String:
	return selected_player["class"]

# Max Health
func set_player_max_health(max_health: float) -> void:
	selected_player["max_health"] = max_health

func get_player_max_health() -> float:
	return selected_player["max_health"]

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
	selected_player["strength_level"] = strength

func get_player_current_strength_level() -> int:
	return selected_player["strength_level"]

# Dexterity
func set_player_current_dexterity_level(dexterity: int) -> void:
	selected_player["dexterity_level"] = dexterity

func get_player_current_dexterity_level() -> int:
	return selected_player["dexterity_level"]

# Intelligence
func set_player_current_intelligence_level(intelligence: int) -> void:
	selected_player["intelligence_level"] = intelligence

func get_player_current_intelligence_level() -> int:
	return selected_player["intelligence_level"]

# Luck
func set_player_current_luck_level(luck: int) -> void:
	selected_player["luck_level"] = luck

func get_player_current_luck_level() -> int:
	return selected_player["luck_level"]

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

func calculate_player_minimum_physical_attack_damage(primary_stat : String, secondary_stat : String, weapon_attack : int):
	var primary = selected_player[primary_stat]
	var secondary = selected_player[secondary_stat]
	selected_player["min_weapon_attack"] = int((((primary+secondary)/100) * weapon_attack)*0.8)

func calculate_player_maximum_physical_attack_damage(primary_stat : String, secondary_stat : String, weapon_attack : int):
	var primary = selected_player[primary_stat]
	var secondary = selected_player[secondary_stat]
	selected_player["max_weapon_attack"] = int(((primary+secondary)/100) * weapon_attack)

func calculate_player_minimum_magic_attack_damage(magic_attack : int) -> void:
	var int_level = get_player_current_intelligence_level()
	selected_player["max_weapon_attack"] = int(((int_level/100) * magic_attack) * 0.8)

func calculate_player_maximum_magic_attack_damage(magic_attack : int) -> void:
	var int_level = get_player_current_intelligence_level()
	selected_player["max_weapon_attack"] = int((int_level/100) * magic_attack)

func calculate_needed_stat_xp(stat_level : String, stat_needed_xp : String) -> void:
	var next_level = selected_player[stat_level]+1
	var required_xp = int(pow(next_level, 1.8) + next_level * 4)
	selected_player[stat_needed_xp] = required_xp

func level_up_stat(stat : String, current_stat_xp : String, needed_stat_xp : String):
	if selected_player[current_stat_xp] >= selected_player[needed_stat_xp]:
		selected_player[stat] += 1
		selected_player[current_stat_xp] = 0
		calculate_needed_stat_xp(stat, needed_stat_xp)

enum WeaponClass {
	WARRIOR,
	MAGE,
	ROGUE
}
