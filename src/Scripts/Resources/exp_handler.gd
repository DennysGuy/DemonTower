class_name EXPHandler extends Resource

@export var stats_resource : Stats
@export var equipped_weapon : Weapon
#Private variables -- these are variables that need calculations
var _total_level: int = 4
var _total_xp_attained: int = 0
#Setting EXP values for all core stat
#Needed XP for the Given Levels
var _str_needed_xp: int = 0
var _dex_needed_xp: int = 0
var _int_needed_xp: int = 0
var _luk_needed_xp: int = 0
#Current EXP Attained for that given level
var _str_current_xp: int = 0
var _dex_current_xp: int = 0
var _int_current_xp: int = 0
var _luk_current_xp: int = 0
# Setters and Getters for total XP
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
# Function to calculate XP needed for leveling
func calculate_needed_stat_xp(stat_level: int) -> int:
	var next_level = stat_level + 1
	return int(pow(next_level, 2.5) + next_level * 4)
# Function to level up a stat based on XP
func level_up_stat(current_stat: int, current_xp: int, needed_xp: int) -> void:
	var roll_over_xp = current_xp - needed_xp
	if current_xp >= needed_xp:
		current_stat += 1
		current_xp = max(roll_over_xp, 0)
		needed_xp = calculate_needed_stat_xp(current_stat)
		calculate_total_level()

func init_needed_xp_for_all_stats():
	set_str_needed_xp(calculate_needed_stat_xp(stats_resource.str_level)) 
	set_dex_needed_xp(calculate_needed_stat_xp(stats_resource.dex_level))
	set_int_needed_xp(calculate_needed_stat_xp(stats_resource.int_level)) 
	set_luk_needed_xp(calculate_needed_stat_xp(stats_resource.luk_level)) 

func track_xp_for_roll_over():
	level_up_stat(stats_resource.str_level, get_str_current_xp(), get_str_needed_xp())
	level_up_stat(stats_resource.int_level, get_int_current_xp(), get_int_needed_xp())
	level_up_stat(stats_resource.dex_level, get_dex_current_xp(), get_dex_needed_xp())
	level_up_stat(stats_resource.luk_level, get_luk_current_xp(), get_luk_needed_xp())	
	
func apply_received_xp(value : int) -> void:
	print_debug("I got " + str(value) + " XP")
	var total_value : int
	match(equipped_weapon.xp_type):
		equipped_weapon.XPType.STRENGTH:
			total_value = get_str_current_xp() + value
			set_str_current_xp(total_value)
			level_up_stat(stats_resource.str_level, get_str_current_xp(), get_str_needed_xp())
		equipped_weapon.XPType.INTELLIGENCE:
			total_value = get_int_current_xp() + value
			set_int_current_xp(total_value)
			level_up_stat(stats_resource.int_level, get_int_current_xp(), get_int_needed_xp())
		equipped_weapon.XPType.DEXLUCK:
			match(equipped_weapon.weapon_class):
				equipped_weapon.WeaponClass.KNIVES:
					set_dex_current_xp(get_dex_current_xp()+(value/4))
					set_luk_current_xp(get_luk_current_xp()+value)
				equipped_weapon.WeaponClass.CLAW:
					set_dex_current_xp(get_dex_current_xp()+value)
					set_luk_current_xp(get_luk_current_xp()+(value/4))
			level_up_stat(stats_resource.dex_level, get_dex_current_xp(), get_dex_needed_xp())
			level_up_stat(stats_resource.luk_level, get_luk_current_xp(), get_luk_needed_xp())
	set_total_xp_attained(get_total_xp_attained()+value)
	
# Function to calculate total level based on multiple stat levels
func calculate_total_level() -> void:
	_total_level = stats_resource.str_level + stats_resource.dex_level + stats_resource.int_level + stats_resource.luk_level
