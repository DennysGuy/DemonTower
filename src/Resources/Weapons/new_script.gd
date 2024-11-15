func level_up_luk_stat(stats_resource : Stats) -> void:
	var luk_level = stats_resource.luk_level
	var luk_current_xp = stats_resource.get_luk_current_xp()
	var luk_needed_xp = stats_resource.get_luk_needed_xp()
	var roll_over_xp = luk_current_xp - luk_needed_xp
	if luk_current_xp >= luk_needed_xp:
		luk_level += 1
		luk_current_xp = max(roll_over_xp, 0)
		luk_needed_xp = calculate_needed_stat_xp(luk_level)
		calculate_total_level(stats_resource)
		
