class_name GlobalStatCalculations extends Node


# Functions for calculating attack damage values
func calculate_minimum_weapon_attack_damage(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	var value = int(((stats_resource.str_level / 100.0) * equipped_weapon.weapon_attack) * 0.8 * 100)
	stats_resource.set_min_weapon_attack(value) 

func calculate_maximum_weapon_attack_damage(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	var value = int(((stats_resource.str_level / 100.0) * equipped_weapon.weapon_attack) * 100)
	stats_resource.set_max_weapon_attack(value)

func calculate_minimum_magic_attack_damage(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	var value = int(((stats_resource.int_level / 100.0) * equipped_weapon.magic_attack) * 0.8 * 100)
	stats_resource.set_min_magic_attack(value)

func calculate_maximum_magic_attack_damage(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	var value = int(((stats_resource.int_level / 100.0) * equipped_weapon.magic_attack) * 100)
	stats_resource.set_max_magic_attack(value)

# Helper function to calculate shadow attack damage based on weapon class
func calculate_shadow_attack_damage(is_max: bool, stats_resource : Stats, equipped_weapon : Weapon) -> int:
	var primary_stat: float
	var secondary_stat: float
	var attack_multiplier: float = 0.8  # Common multiplier for both min and max damage calculation
	var adjusted_attack: float

	# Weapon-specific logic for primary and secondary stat selection
	match equipped_weapon.weapon_class:
		equipped_weapon.WeaponClass.KNIVES:
			primary_stat = stats_resource.luk_level
			secondary_stat = stats_resource.dex_level / 4
		equipped_weapon.WeaponClass.CLAW:
			primary_stat = stats_resource.dex_level
			secondary_stat = stats_resource.luk_level / 4
		_:
			return 0  # Default if no valid weapon class is found

	# Calculate damage based on primary and secondary stats
	adjusted_attack = primary_stat + secondary_stat
	adjusted_attack = (adjusted_attack / 100 * equipped_weapon.shadow_attack ) * 100

	# Apply multiplier for minimum or maximum damage calculation
	if !is_max:
		adjusted_attack *= attack_multiplier

	return int(adjusted_attack)

# Function to calculate minimum shadow attack damage
func calculate_minimum_shadow_attack_damage(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	var value = calculate_shadow_attack_damage(false, stats_resource, equipped_weapon)
	stats_resource.set_min_shadow_attack(value) 

# Function to calculate maximum shadow attack damage
func calculate_max_shadow_attack_damage(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	stats_resource.set_max_shadow_attack(calculate_shadow_attack_damage(true, stats_resource, equipped_weapon)) 

# Functions to calculate weapon and magic defenses
func calculate_weapon_defense(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	var value = int(equipped_weapon.weapon_defense/ (equipped_weapon.weapon_defense + (100 * stats_resource.str_level)))
	stats_resource.set_player_true_weapon_defense(value)

func calculate_magic_defense(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	var value = int(equipped_weapon.magic_defense / (equipped_weapon.magic_defense + (100 * stats_resource.int_level)))
	stats_resource.set_player_true_magic_defense(value)

func calculate_avoidability(shadow_defense: int, luck_level: int) -> int:
	return 0

func init_necessary_stat_calculations(stats_resource : Stats, equipped_weapon : Weapon) -> void:
	calculate_minimum_weapon_attack_damage(stats_resource, equipped_weapon)
	calculate_maximum_weapon_attack_damage(stats_resource, equipped_weapon)
	calculate_minimum_magic_attack_damage(stats_resource, equipped_weapon)
	calculate_maximum_magic_attack_damage(stats_resource, equipped_weapon)
	calculate_minimum_shadow_attack_damage(stats_resource, equipped_weapon)
	calculate_max_shadow_attack_damage(stats_resource, equipped_weapon)
	calculate_weapon_defense(stats_resource, equipped_weapon)
	calculate_magic_defense(stats_resource, equipped_weapon)
