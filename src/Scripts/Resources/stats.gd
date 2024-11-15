class_name Stats extends Resource

# Define the properties that will appear in the Inspector
@export_group("Meta Data")
@export var name: String
@export var color: String
@export var max_health: float = 100.0
@export var current_health: float = 100.0
@export var magic_points: int = 100
@export var current_magic_points: int = 100

# Cores Stats
# Core Attributes 
@export_group("Core Attributes")
@export var str_level: int = 1
@export var dex_level: int = 1
@export var int_level: int = 1
@export var luk_level: int = 1

# Secondary Stats
# Supplementary
@export_group("Supplementary Stats")
@export var critical_rate: int = 0
@export var critical_damage: int = 5
@export var avoidability: int = 10
@export var accuracy: int = 10
@export var speed: int = 120
@export var jump: int = 200

var _true_weapon_defense: int
var _true_magic_defense: int
var _true_shadow_defense: int

# Attack Values
# Warrior Weapon Stats
var _min_weapon_attack: int = 0
var _max_weapon_attack: int = 0

# Mage Weapon Stats
var _min_magic_attack: int = 0
var _max_magic_attack: int = 0

# Thief Weapon Stats
var _min_shadow_attack: int = 0
var _max_shadow_attack: int = 0

# Getter and Setter for Warrior Weapon Stats
func set_min_weapon_attack(value: int) -> void:
	_min_weapon_attack = value

func get_min_weapon_attack() -> int:
	return _min_weapon_attack

func set_max_weapon_attack(value: int) -> void:
	_max_weapon_attack = value

func get_max_weapon_attack() -> int:
	return _max_weapon_attack

# Getter and Setter for Mage Weapon Stats
func set_min_magic_attack(value: int) -> void:
	_min_magic_attack = value

func get_min_magic_attack() -> int:
	return _min_magic_attack

func set_max_magic_attack(value: int) -> void:
	_max_magic_attack = value

func get_max_magic_attack() -> int:
	return _max_magic_attack

# Getter and Setter for Thief Weapon Stats
func set_min_shadow_attack(value: int) -> void:
	_min_shadow_attack = value

func get_min_shadow_attack() -> int:
	return _min_shadow_attack

func set_max_shadow_attack(value: int) -> void:
	_max_shadow_attack = value

func get_max_shadow_attack() -> int:
	return _max_shadow_attack

# Setters and Getters for Weapon Defenses
func set_player_true_weapon_defense(value: int) -> void:
	_true_weapon_defense = value

func get_player_true_weapon_defense() -> int:
	return _true_weapon_defense

func set_player_true_magic_defense(value: int) -> void:
	_true_magic_defense = value

func get_player_true_magic_defense() -> int:
	return _true_magic_defense
