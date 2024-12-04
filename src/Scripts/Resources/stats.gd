class_name Stats extends Resource

# Define the properties that will appear in the Inspector
@export_group("Meta Data")
@export var name: String
@export var color: String
@export var max_health: float = 100.0
@export var current_health: float = 100.0
@export var magic_points: int = 100
@export var current_magic_points: int = 100

@export_group("Equipped Archetype")
@export_enum("Warrior", "Mage", "Rogue") var equipped_archetype : int
# Cores Stats
# Core Attributes 
@export_group("Core Attributes")
@export var str_level: int = 1
@export var dex_level: int = 1
@export var int_level: int = 1
@export var luk_level: int = 1
@export var mining_level: int = 1
@export var smelting_level: int = 1
@export var crafting_level: int = 1
@export var wood_cutting_level: int = 1
@export var fire_making_level: int = 1
@export var cooking_level: int = 1

# Secondary Stats
# Supplementary
@export_group("Supplementary Stats")
@export var critical_rate: float = 0
@export var critical_damage: float = 0
@export var avoidability: float = 10
@export var accuracy: float = 10
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

func set_equipped_archetype(weapon_archetype : int):
	match(weapon_archetype):
		0:
			equipped_archetype = 0
		1:
			equipped_archetype = 1
		2: 
			equipped_archetype = 2

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
func set_true_weapon_defense(value: int) -> void:
	_true_weapon_defense = value

func get_true_weapon_defense() -> int:
	return _true_weapon_defense

func set_true_magic_defense(value: int) -> void:
	_true_magic_defense = value

func get_true_magic_defense() -> int:
	return _true_magic_defense
	
#Private variables -- these are variables that need calculations
var _total_level: int = 4
var _total_xp_attained: int = 0
@export_group("XP")
@export var xp_value : int
#Setting EXP values for all core stat
#Needed XP for the Given Levels
var _str_needed_xp: int = 0
var _dex_needed_xp: int = 0
var _int_needed_xp: int = 0
var _luk_needed_xp: int = 0
var _mining_needed_xp: int = 0
var _smelting_needed_xp: int = 0
var _crafting_needed_xp: int = 0
var _woodcutting_needed_xp: int = 0
var _firemaking_needed_xp: int = 0
var _cooking_needed_xp: int = 0
#Current EXP Attained for that given level
var _str_current_xp: int = 0
var _dex_current_xp: int = 0
var _int_current_xp: int = 0
var _luk_current_xp: int = 0
var _mining_current_xp: int = 0
var _smelting_current_xp: int = 0
var _crafting_current_xp: int = 0
var _woodcutting_current_xp: int = 0
var _firemaking_current_xp: int = 0
var _cooking_current_xp: int = 0
# Setters and Getters for total XP
func get_total_level() -> int:
	return _total_level

func set_total_level(value : int ) -> void:
	_total_level = value

func set_total_xp_attained(value: int) -> void:
	_total_xp_attained = value

func get_total_xp_attained() -> int:
	return _total_xp_attained

# Setters and Getters for Strength XP
func set_str_needed_xp(value: int) -> void:
	_str_needed_xp = value

func get_str_needed_xp() -> int:
	return _str_needed_xp

func set_str_current_xp(value: int) -> void:
	_str_current_xp = value

func get_str_current_xp() -> int:
	return _str_current_xp

# Setters and Getters for Dexterity XP
func set_dex_needed_xp(value: int) -> void:
	_dex_needed_xp = value

func get_dex_needed_xp() -> int:
	return _dex_needed_xp

func set_dex_current_xp(value: int) -> void:
	_dex_current_xp = value

func get_dex_current_xp() -> int:
	return _dex_current_xp

# Setters and Getters for Intelligence XP
func set_int_needed_xp(value: int) -> void:
	_int_needed_xp = value

func get_int_needed_xp() -> int:
	return _int_needed_xp

func set_int_current_xp(value: int) -> void:
	_int_current_xp = value

func get_int_current_xp() -> int:
	return _int_current_xp

# Setters and Getters for Luck XP
func set_luk_needed_xp(value: int) -> void:
	_luk_needed_xp = value

func get_luk_needed_xp() -> int:
	return _luk_needed_xp

func set_luk_current_xp(value: int) -> void:
	_luk_current_xp = value

func get_luk_current_xp() -> int:
	return _luk_current_xp

# Getters and Setters
func set_mining_needed_xp(value: int) -> void:
	_mining_needed_xp = value

func get_mining_needed_xp() -> int:
	return _mining_needed_xp

func set_smelting_needed_xp(value: int) -> void:
	_smelting_needed_xp = value

func get_smelting_needed_xp() -> int:
	return _smelting_needed_xp

func set_crafting_needed_xp(value: int) -> void:
	_crafting_needed_xp = value

func get_crafting_needed_xp() -> int:
	return _crafting_needed_xp

func set_woodcutting_needed_xp(value: int) -> void:
	_woodcutting_needed_xp = value

func get_woodcutting_needed_xp() -> int:
	return _woodcutting_needed_xp

func set_firemaking_needed_xp(value: int) -> void:
	_firemaking_needed_xp = value

func get_firemaking_needed_xp() -> int:
	return _firemaking_needed_xp

func set_cooking_needed_xp(value: int) -> void:
	_cooking_needed_xp = value

func get_cooking_needed_xp() -> int:
	return _cooking_needed_xp

func set_mining_current_xp(value: int) -> void:
	_mining_current_xp = value

func get_mining_current_xp() -> int:
	return _mining_current_xp

func set_smelting_current_xp(value: int) -> void:
	_smelting_current_xp = value

func get_smelting_current_xp() -> int:
	return _smelting_current_xp

func set_crafting_current_xp(value: int) -> void:
	_crafting_current_xp = value

func get_crafting_current_xp() -> int:
	return _crafting_current_xp

func set_woodcutting_current_xp(value: int) -> void:
	_woodcutting_current_xp = value

func get_woodcutting_current_xp() -> int:
	return _woodcutting_current_xp

func set_firemaking_current_xp(value: int) -> void:
	_firemaking_current_xp = value

func get_firemaking_current_xp() -> int:
	return _firemaking_current_xp

func set_cooking_current_xp(value: int) -> void:
	_cooking_current_xp = value

func get_cooking_current_xp() -> int:
	return _cooking_current_xp
