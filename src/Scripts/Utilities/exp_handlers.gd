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
		#we'll need to do any of secondary stat increases here
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

func level_up_mining_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_mining_current_xp() - stats_resource.get_mining_needed_xp()
	if stats_resource.get_mining_current_xp() >= stats_resource.get_mining_needed_xp():
		stats_resource.mining_level += 1
		stats_resource.set_mining_current_xp(max(roll_over_xp, 0))
		stats_resource.set_mining_needed_xp(calculate_needed_stat_xp(stats_resource.mining_level))
		calculate_total_level(stats_resource)

func level_up_smelting_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_smelting_current_xp() - stats_resource.get_smelting_needed_xp()
	if stats_resource.get_smelting_current_xp() >= stats_resource.get_smelting_needed_xp():
		stats_resource.smelting_level += 1
		stats_resource.set_smelting_current_xp(max(roll_over_xp, 0))
		stats_resource.set_smelting_needed_xp(calculate_needed_stat_xp(stats_resource.smelting_level))
		calculate_total_level(stats_resource)

func level_up_crafting_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_crafting_current_xp() - stats_resource.get_crafting_needed_xp()
	if stats_resource.get_crafting_current_xp() >= stats_resource.get_crafting_needed_xp():
		stats_resource.crafting_level += 1
		stats_resource.set_crafting_current_xp(max(roll_over_xp, 0))
		stats_resource.set_crafting_needed_xp(calculate_needed_stat_xp(stats_resource.crafting_level))
		calculate_total_level(stats_resource)

func level_up_woodcutting_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_woodcutting_current_xp() - stats_resource.get_woodcutting_needed_xp()
	if stats_resource.get_woodcutting_current_xp() >= stats_resource.get_woodcutting_needed_xp():
		stats_resource.wood_cutting_level += 1
		stats_resource.set_woodcutting_current_xp(max(roll_over_xp, 0))
		stats_resource.set_woodcutting_needed_xp(calculate_needed_stat_xp(stats_resource.wood_cutting_level))
		calculate_total_level(stats_resource)

func level_up_firemaking_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_firemaking_current_xp() - stats_resource.get_firemaking_needed_xp()
	if stats_resource.get_firemaking_current_xp() >= stats_resource.get_firemaking_needed_xp():
		stats_resource.fire_making_level += 1
		stats_resource.set_firemaking_current_xp(max(roll_over_xp, 0))
		stats_resource.set_firemaking_needed_xp(calculate_needed_stat_xp(stats_resource.fire_making_level))
		calculate_total_level(stats_resource)

func level_up_cooking_stat(stats_resource: Stats) -> void:
	var roll_over_xp = stats_resource.get_cooking_current_xp() - stats_resource.get_cooking_needed_xp()
	if stats_resource.get_cooking_current_xp() >= stats_resource.get_cooking_needed_xp():
		stats_resource.cooking_level += 1
		stats_resource.set_cooking_current_xp(max(roll_over_xp, 0))
		stats_resource.set_cooking_needed_xp(calculate_needed_stat_xp(stats_resource.cooking_level))
		calculate_total_level(stats_resource)

func init_needed_xp_for_all_stats(stats_resource : Stats):
	stats_resource.set_str_needed_xp(calculate_needed_stat_xp(stats_resource.str_level)) 
	stats_resource.set_dex_needed_xp(calculate_needed_stat_xp(stats_resource.dex_level))
	stats_resource.set_int_needed_xp(calculate_needed_stat_xp(stats_resource.int_level)) 
	stats_resource.set_luk_needed_xp(calculate_needed_stat_xp(stats_resource.luk_level)) 
	stats_resource.set_mining_needed_xp(calculate_needed_stat_xp(stats_resource.mining_level))
	stats_resource.set_smelting_needed_xp(calculate_needed_stat_xp(stats_resource.smelting_level))
	stats_resource.set_woodcutting_needed_xp(calculate_needed_stat_xp(stats_resource.wood_cutting_level))
	stats_resource.set_firemaking_needed_xp(calculate_needed_stat_xp(stats_resource.fire_making_level))
	stats_resource.set_cooking_needed_xp(calculate_needed_stat_xp(stats_resource.cooking_level))

func track_xp_for_roll_over(stats_resource : Stats):
	level_up_str_stat(stats_resource)
	level_up_dex_stat(stats_resource)
	level_up_int_stat(stats_resource)
	level_up_luk_stat(stats_resource)
	level_up_mining_stat(stats_resource)
	level_up_smelting_stat(stats_resource)
	level_up_crafting_stat(stats_resource)
	level_up_woodcutting_stat(stats_resource)
	level_up_cooking_stat(stats_resource)
	
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
	stats_resource.set_total_level(stats_resource.str_level + stats_resource.dex_level + stats_resource.int_level + stats_resource.luk_level + stats_resource.mining_level + stats_resource.smelting_level + stats_resource.crafting_level + stats_resource.wood_cutting_level + stats_resource.fire_making_level + stats_resource.cooking_level) 
