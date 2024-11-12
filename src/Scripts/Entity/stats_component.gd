class_name StatsComponent extends Node

# Private variables
@export_group("Level")
@export var _level : int

@export_group("HP")
@export var _max_health : float
@export var _current_health : float

@export_group("MP")
@export var _magic_points : float
@export var _current_magic_points : float

@export_group("XP")
@export var _xp_needed : float
@export var _current_xp: float

@export_group("Core Stats")
@export var _strength : int
@export var _dexterity : int
@export var _intelligence : int
@export var _luck : int

@export_group("Secondary Stats")
@export var _minimum_attack : int
@export var _maximum_attack : int
@export var _magic : int
@export var _critical_rate : int
@export var _critical_damage : int
@export var _accuracy : int
@export var _weapon_defense : float
@export var _defense : int
@export var _speed : int
@export var _jump : int

@export_group("Misc Rates")
@export var _drop_rate : int
@export var _xp_rate : int

#variable stats


# Setter and getter functions

# Level
func set_level(value: int) -> void:
	_level = value

func get_level() -> int:
	return _level

# Max Health
func set_max_health(value: float) -> void:
	_max_health = value

func get_max_health() -> float:
	return _max_health

# Current Health
func set_current_health(value: float) -> void:
	_current_health = value

func get_current_health() -> float:
	return _current_health

# Magic Points
func set_magic_points(value: float) -> void:
	_magic_points = value

func get_magic_points() -> float:
	return _magic_points

# Current Magic Points
func set_current_magic_points(value: float) -> void:
	_current_magic_points = value

func get_current_magic_points() -> float:
	return _current_magic_points

# EXP
func set_xp_needed(value: int) -> void:
	_xp_needed = value

func get_xp_need() -> int:
	return _xp_needed
	
func set_current_xp(value: int) -> void:
	_current_xp = value

func get_current_xp() -> int:
	return _current_xp

# Strength
func set_strength(value: int) -> void:
	_strength = value

func get_strength() -> int:
	return _strength

# Dexterity
func set_dexterity(value: int) -> void:
	_dexterity = value

func get_dexterity() -> int:
	return _dexterity

# Intelligence
func set_intelligence(value: int) -> void:
	_intelligence = value

func get_intelligence() -> int:
	return _intelligence

# Luck
func set_luck(value: int) -> void:
	_luck = value

func get_luck() -> int:
	return _luck

# Magic Power
func set_magic_power(value: int) -> void:
	_magic = value

func get_magic_power() -> int:
	return _magic

# Critical Rate
func set_critical_rate(value: int) -> void:
	_critical_rate = value

func get_critical_rate() -> int:
	return _critical_rate

# Critical Damage
func set_critical_damage(value: int) -> void:
	_critical_damage = value

func get_critical_damage() -> int:
	return _critical_damage

# Defense
func set_defense(value: int) -> void:
	_defense = value

func get_defense() -> int:
	return _defense

func get_weapon_defense() -> float:
	return _weapon_defense

# Speed
func set_speed(value: int) -> void:
	_speed = value

func get_speed() -> int:
	return _speed

# Jump
func set_jump(value: int) -> void:
	_jump = value

func get_jump() -> int:
	return _jump

# Drop Rate
func set_drop_rate(value: int) -> void:
	_drop_rate = value

func get_drop_rate() -> int:
	return _drop_rate

# XP Rate
func set_xp_rate(value: int) -> void:
	_xp_rate = value

func get_xp_rate() -> int:
	return _xp_rate

# Attack Range
func get_minimum_attack() -> int:
	return _minimum_attack

func get_maximum_attack() -> int:
	return _maximum_attack

# Calculations
var _min_damage_modifer = 0.8 #we can adjust this as needed to balance things
func calculate_attack_range(primary_stat : int, secondary_stat: int, weapon_multiplier: float, weapon_attack : int) -> int:
	#base formula for attack range is ((primary_stat + (secondary_stat/4)/100) x weapon_multiplier x weapon_attack
	return int(((primary_stat + (secondary_stat/4)/100) * weapon_multiplier * weapon_attack))

func calculate_minimum_attack(primary_stat : int, secondary_stat: int,  weapon_multiplier: float, weapon_attack : int) -> void:
	self._minimum_attack = calculate_attack_range(primary_stat, secondary_stat, weapon_multiplier, weapon_attack) * _min_damage_modifer

func calculate_maximum_attack(primary_stat : int, secondary_stat: int, weapon_multiplier: float, weapon_attack : int) -> void:
	self._maximum_attack = calculate_attack_range(primary_stat, secondary_stat, weapon_multiplier, weapon_attack)

func calculate_weapon_defense(temp_wdef_val : int) -> void:
	self._weapon_defense = temp_wdef_val/(temp_wdef_val + (100 * get_level()))

func calculate_magic() -> void:
	#we're going to take in all resources that give magic attack and add it to intellect level
	pass

func calculate_minimum_magic_attack() -> void:
	#take base damage (base damage of specific magic skill
	pass	

func calculate_maximum_magic_attack() -> void:
	pass

func calculate_critical_rate() -> void:
	#add up base crit with bonuses from resources, active or passive skills, and buffs subtract enemy debuff if applicable
	#calculating base crit rate won't take in enemy debuff for obvious reasons
	pass

func calculate_accuracy() -> void:
	pass
	
func calculate_avoidability() -> void:
	pass	
