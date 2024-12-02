class_name EXPHandlers extends Node

func calculate_needed_stat_xp(stat_level: int) -> int:
	var next_level = stat_level + 1
	return int(pow(next_level, 2.5) + next_level * 4)
# Function to level up a stat based on XP
func level_up_str_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_str_current_xp() - stats_resource.get_str_needed_xp()
	if stats_resource.get_str_current_xp() >= stats_resource.get_str_needed_xp():
		stats_resource.str_level += 1
		stats_resource.set_str_current_xp(max(roll_over_xp, 0))
		stats_resource.set_str_needed_xp(calculate_needed_stat_xp(stats_resource.str_level))
		calculate_total_level(stats_resource)

func level_up_dex_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_dex_current_xp() - stats_resource.get_dex_needed_xp()
	if stats_resource.get_dex_current_xp() >= stats_resource.get_dex_needed_xp():
		stats_resource.dex_level += 1
		stats_resource.set_dex_current_xp(max(roll_over_xp, 0))
		stats_resource.set_dex_needed_xp(calculate_needed_stat_xp(stats_resource.dex_level))
		calculate_total_level(stats_resource)

func level_up_int_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_int_current_xp() - stats_resource.get_int_needed_xp()
	if stats_resource.get_int_current_xp() >= stats_resource.get_int_needed_xp():
		stats_resource.int_level += 1
		stats_resource.set_int_current_xp(max(roll_over_xp, 0))
		stats_resource.set_int_needed_xp(calculate_needed_stat_xp(stats_resource.int_level))
		calculate_total_level(stats_resource)

func level_up_luk_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_luk_current_xp() - stats_resource.get_luk_needed_xp()
	if stats_resource.get_luk_current_xp() >= stats_resource.get_luk_needed_xp():
		stats_resource.luk_level += 1
		stats_resource.set_luk_current_xp(max(roll_over_xp, 0))
		stats_resource.set_luk_needed_xp(calculate_needed_stat_xp(stats_resource.luk_level))
		calculate_total_level(stats_resource)



func init_needed_xp_for_all_stats(stats_resource : Stats):
	stats_resource.set_str_needed_xp(calculate_needed_stat_xp(stats_resource.str_level)) 
	stats_resource.set_dex_needed_xp(calculate_needed_stat_xp(stats_resource.dex_level))
	stats_resource.set_int_needed_xp(calculate_needed_stat_xp(stats_resource.int_level)) 
	stats_resource.set_luk_needed_xp(calculate_needed_stat_xp(stats_resource.luk_level)) 

func track_xp_for_roll_over(stats_resource : Stats):
	level_up_str_stat(stats_resource)
	level_up_dex_stat(stats_resource)
	level_up_int_stat(stats_resource)
	level_up_luk_stat(stats_resource)
	
func apply_received_xp(value : int, equipped_weapon : Weapon, stats_resource : Stats) -> void:
	print_debug("I got " + str(value) + " XP")
	var total_value : int
	match(equipped_weapon.xp_type):
		equipped_weapon.XPType.STRENGTH:
			total_value = stats_resource.get_str_current_xp() + value
			stats_resource.set_str_current_xp(total_value)
			stats_resource.level_up_stat(stats_resource.str_level, stats_resource.get_str_current_xp(), stats_resource.get_str_needed_xp())
		equipped_weapon.XPType.INTELLIGENCE:
			total_value = stats_resource.get_int_current_xp() + value
			stats_resource.set_int_current_xp(total_value)
		equipped_weapon.XPType.DEXLUCK:
			match(equipped_weapon.weapon_class):
				equipped_weapon.WeaponClass.KNIVES:
					stats_resource.set_dex_current_xp(stats_resource.get_dex_current_xp()+(value/4))
					stats_resource.set_luk_current_xp(stats_resource.get_luk_current_xp()+value)
				equipped_weapon.WeaponClass.CLAW:
					stats_resource.set_dex_current_xp(stats_resource.get_dex_current_xp()+value)
					stats_resource.set_luk_current_xp(stats_resource.get_luk_current_xp()+(value/4))
			stats_resource.level_up_stat(stats_resource.dex_level, stats_resource.get_dex_current_xp(), stats_resource.get_dex_needed_xp())
			stats_resource.level_up_stat(stats_resource.luk_level, stats_resource.get_luk_current_xp(), stats_resource.get_luk_needed_xp())
	stats_resource.set_total_xp_attained(stats_resource.get_total_xp_attained()+value)
	
# Function to calculate total level based on multiple stat levels
func calculate_total_level(stats_resource : Stats) -> void:
	stats_resource.set_total_level(stats_resource.str_level + stats_resource.dex_level + stats_resource.int_level + stats_resource.luk_level) 
