extends Node

var players = {}
var selected_player = {
	"name": "",
	"color": "",
	"class": "Warrior",
	"max_health": 25.0, #for setting initial health
	"current_health": 25.0, #keeping track of current health
	"magic_points": 100,
	"current_magic_points": 100,
	"current_level": 1,
	"xp_needed": 50,
	"current_xp": 28,
	"strength": 10,
	"dexterity": 10,
	"intelligence": 10,
	"luck": 10,
	"attack_power": 15,
	"magic_attack": 15,
	"critical_rate": 0,
	"critical_damage": 0,
	"defense": 5,
	"xp_rate": 1,
	"drop_rate": 1,
	"speed": 150,
	"jump": 250
}
var selected_color : String = selected_player["color"]
var character_name : String = selected_player["name"]
var player_health : float = selected_player["max_health"]
var player_current_health : float = selected_player["current_health"]
var player_magic_points : float = selected_player["magic_points"]
var player_current_magic_points : float = selected_player["current_magic_points"]
var current_level : int = selected_player["current_level"]
var xp_needed : int = selected_player["xp_needed"]
var current_xp : int = selected_player["current_xp"]
var strength : int = selected_player["strength"]
var dexterity : int = selected_player["dexterity"]
var intelligence : int = selected_player["intelligence"]
var luck : int = selected_player["luck"]
var attack_power : int = selected_player["attack_power"]
var magic_power : int = selected_player["magic_attack"]
var critical_rate : int = selected_player["critical_rate"]
var critical_damage : int = selected_player["critical_damage"]
var defense : int = selected_player["defense"]
var speed : int = selected_player["speed"]
var jump : int = selected_player["jump"]
var drop_rate : int = selected_player["drop_rate"]
var xp_rate : int = selected_player["xp_rate"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
func set_color(color: String) -> void:
	selected_player["color"] = color

func get_color() -> String:
	return selected_player["color"]

# Player Class
func set_player_class(new_class: String) -> void:
	selected_player["class"] = new_class

func get_player_class() -> String:
	return selected_player["class"]

# Max Health
func set_max_health(max_health: float) -> void:
	selected_player["max_health"] = max_health

func get_max_health() -> float:
	return selected_player["max_health"]

# Current Health
func set_current_health(current_health: float) -> void:
	selected_player["current_health"] = current_health

func get_current_health() -> float:
	return selected_player["current_health"]

# Magic Points
func set_magic_points(magic_points: int) -> void:
	selected_player["magic_points"] = magic_points

func get_magic_points() -> int:
	return selected_player["magic_points"]

# Current Magic Points
func set_current_magic_points(current_magic_points: int) -> void:
	selected_player["current_magic_points"] = current_magic_points

func get_current_magic_points() -> int:
	return selected_player["current_magic_points"]

# Current Level
func set_current_level(level: int) -> void:
	selected_player["current_level"] = level

func get_current_level() -> int:
	return selected_player["current_level"]

# XP Needed
func set_xp_needed(xp_needed: int) -> void:
	selected_player["xp_needed"] = xp_needed

func get_xp_needed() -> int:
	return selected_player["xp_needed"]

# Current XP
func set_current_xp(current_xp: int) -> void:
	selected_player["current_xp"] = current_xp

func get_current_xp() -> int:
	return selected_player["current_xp"]

# Strength
func set_strength(strength: int) -> void:
	selected_player["strength"] = strength

func get_strength() -> int:
	return selected_player["strength"]

# Dexterity
func set_dexterity(dexterity: int) -> void:
	selected_player["dexterity"] = dexterity

func get_dexterity() -> int:
	return selected_player["dexterity"]

# Intelligence
func set_intelligence(intelligence: int) -> void:
	selected_player["intelligence"] = intelligence

func get_intelligence() -> int:
	return selected_player["intelligence"]

# Luck
func set_luck(luck: int) -> void:
	selected_player["luck"] = luck

func get_luck() -> int:
	return selected_player["luck"]

# Attack Power
func set_attack_power(attack_power: int) -> void:
	selected_player["attack_power"] = attack_power

func get_attack_power() -> int:
	return selected_player["attack_power"]

# Magic Attack
func set_magic_attack(magic_attack: int) -> void:
	selected_player["magic_attack"] = magic_attack

func get_magic_attack() -> int:
	return selected_player["magic_attack"]

# Critical Rate
func set_critical_rate(critical_rate: int) -> void:
	selected_player["critical_rate"] = critical_rate

func get_critical_rate() -> int:
	return selected_player["critical_rate"]

# Critical Damage
func set_critical_damage(critical_damage: int) -> void:
	selected_player["critical_damage"] = critical_damage

func get_critical_damage() -> int:
	return selected_player["critical_damage"]

# Defense
func set_defense(defense: int) -> void:
	selected_player["defense"] = defense

func get_defense() -> int:
	return selected_player["defense"]

# XP Rate
func set_xp_rate(xp_rate: int) -> void:
	selected_player["xp_rate"] = xp_rate

func get_xp_rate() -> int:
	return selected_player["xp_rate"]

# Drop Rate
func set_drop_rate(drop_rate: int) -> void:
	selected_player["drop_rate"] = drop_rate

func get_drop_rate() -> int:
	return selected_player["drop_rate"]

# Speed
func set_speed(speed: int) -> void:
	selected_player["speed"] = speed

func get_speed() -> int:
	return selected_player["speed"]

# Jump
func set_jump(jump: int) -> void:
	selected_player["jump"] = jump

func get_jump() -> int:
	return selected_player["jump"]
