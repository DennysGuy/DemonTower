extends Control

@export var player : Player
#player description labels
@onready var level_label : Label = $SkillsXPMenu/VBoxContainer/LevelLabel
@onready var player_name_label : Label = $HUD/HBoxContainer/PlayerDescriptionMargin/PlayerDescriptionBox/PlayerName

#stat bar stuff
#HP Bar
@onready var hit_points_label : Label = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/HPBar/HitPointsLabel
@onready var hp_bar : ProgressBar = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/HPBar/HPBar
#MP Bar
@onready var magic_points_label : Label = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/MPBar/MagicPointsLabel
@onready var mp_bar : ProgressBar = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/MPBar/MPBar
#XP Bars
#XP WINDOW
@onready var XP_menu : Panel = $SkillsXPMenu
#STR XP
@onready var str_xp_label : Label = $SkillsXPMenu/VBoxContainer/STRXP_Label
@onready var str_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/STRXP_ProgressBar
#DEX XP
@onready var dex_xp_label : Label = $SkillsXPMenu/VBoxContainer/DEXXP_Label
@onready var dex_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/DEXXP_ProgressBar
#INT XP
@onready var int_xp_label : Label = $SkillsXPMenu/VBoxContainer/INTXP_Lable
@onready var int_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/INTXP_ProgressBar
#LUK XP
@onready var luk_xp_label : Label = $SkillsXPMenu/VBoxContainer/LUKXP_Label
@onready var luk_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/LUKXP_ProgresBar
#Pause Menu Button
@onready var menu_button : Button = $HUD/HBoxContainer/MiscMargin/Misc/MenuButton
#STATS panel
#Player Details
@onready var stats_panel : Panel = $StatsPanel
@onready var total_level_label : Label = $StatsPanel/CharacterStatsLabel
@onready var name_label : Label = $StatsPanel/PlayerDetail/VBoxContainer/NameLabel
@onready var equipped_archetype : Label = $StatsPanel/PlayerDetail/VBoxContainer/EquippedArchetype
@onready var total_level : Label = $StatsPanel/PlayerDetail/VBoxContainer/TotalLevel
@onready var HP : Label = $StatsPanel/PlayerDetail/VBoxContainer/HP
@onready var MP : Label = $StatsPanel/PlayerDetail/VBoxContainer/MP
#Ability Levels
@onready var str_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/StrLvl
@onready var dex_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/DexLvl
@onready var int_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/IntLvl
@onready var luk_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/LukLvl
#Secondary Details
@onready var secondary_stats_panel : Panel = $StatsPanel/SecondaryStats
@onready var p_atk : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/PATK
@onready var m_atk : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/MATK
@onready var s_atk : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/SATK
@onready var w_def : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/WDEF
@onready var m_def : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/MDEF
@onready var s_def : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/SDEF
@onready var acc : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/ACC
@onready var avoid : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/AVOID
@onready var speed : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/SPEED
@onready var jump : Label = $StatsPanel/SecondaryStats/ColorRect/VBoxContainer/JMP

var xp_menu_show
var stats_panel_show
var secondary_stats_panel_show
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	xp_menu_show = false
	stats_panel_show = false
	secondary_stats_panel_show = false
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Player Description Displayers
	level_label.text = "Total Level " + str(player.exp_handler._total_level)
	player_name_label.text = player.player_stats.name
	#HP Displayers
	hit_points_label.text = "HP " + "["+str(player.player_stats.current_health)+"/"+str(player.player_stats.max_health)+"]"
	hp_bar.max_value = player.player_stats.max_health
	hp_bar.value = player.player_stats.current_health
	#MP Displayers
	magic_points_label.text = "MP " + "["+str(player.player_stats.current_magic_points)+"/"+str(player.player_stats.magic_points)+"]"
	mp_bar.max_value = player.player_stats.magic_points
	mp_bar.value = player.player_stats.current_magic_points
	
	if Input.is_action_just_pressed("stats"):
		stats_panel_show = !stats_panel_show
	#Displays primary stats when toggled
	if stats_panel_show:
		name_label.text = "Name: " + player.player_stats.name
		equipped_archetype.text = "Equipped Archetype: " + str(player.equipped_weapon.archetype_class)
		total_level.text = "Total Level: " + str(player.exp_handler._total_level)
		#total exp needed
		HP.text = "HP: "+"["+str(player.player_stats.current_health)+"/"+str(player.player_stats.max_health)+"]"
		MP.text = "MP: "+"["+str(player.player_stats.current_magic_points)+"/"+str(player.player_stats.magic_points)+"]"
		str_lvl.text = "STR LVL: " + str(player.player_stats.str_level)
		dex_lvl.text = "DEX LVL: " + str(player.player_stats.dex_level)
		int_lvl.text = "INT LVL: " + str(player.player_stats.int_level)
		luk_lvl.text = "LUK LVL: " + str(player.player_stats.luk_level)
		stats_panel.show()
	else:
		stats_panel.hide()
	
	#Displays secondary stats when toggled
	if secondary_stats_panel_show:
		p_atk.text = "Weapon Attack: " + str(player.player_stats.get_min_weapon_attack()) +" ~ " + str(player.player_stats.get_max_weapon_attack())
		m_atk.text = "Magic Attack: " + str(player.player_stats.get_min_magic_attack()) + " ~ " +str(player.player_stats.get_max_magic_attack())
		s_atk.text = "Shadow Attack: " + str(player.player_stats.get_min_shadow_attack()) + " ~ " + str(player.player_stats.get_max_shadow_attack())
		w_def.text = "Weapon Defense: " + str(player.equipped_weapon.get_weapon_defense())
		m_def.text = "Magic Defense: " + str(player.equipped_weapon.get_weapon_magic_defense())
		acc.text = "Accuracy: " + str(player.player_stats.accuracy)
		avoid.text = "Avoidability: " +str(player.player_stats.avoidability)
		speed.text = "Speed: " + str(player.player_stats.speed)
		jump.text = "Jump: " + str(player.player_stats.jump) 
		secondary_stats_panel.show()
	else:
		secondary_stats_panel.hide()
	
	if xp_menu_show:
		#XP Displayers
		#STR Display
		str_xp_label.text = "STR XP" + "["+str(player.exp_handler.get_str_current_xp())+"/"+str(player.exp_handler.get_str_needed_xp())+"]"
		str_xp_progressbar.max_value = player.exp_handler.get_str_needed_xp()
		str_xp_progressbar.value = player.exp_handler.get_str_current_xp()
		#DEX Display
		dex_xp_label.text = "DEX XP" + "["+str(player.exp_handler.get_dex_current_xp())+"/"+str(player.exp_handler.get_dex_needed_xp())+"]"
		dex_xp_progressbar.max_value = player.exp_handler.get_dex_needed_xp()
		dex_xp_progressbar.value = player.exp_handler.get_dex_current_xp()
		#INT Display
		int_xp_label.text = "INT XP" + "["+str(player.exp_handler.get_int_current_xp())+"/"+str(player.exp_handler.get_int_needed_xp())+"]"
		int_xp_progressbar.max_value = player.exp_handler.get_int_needed_xp()
		int_xp_progressbar.value = player.exp_handler.get_int_current_xp()
		#LUK Display
		luk_xp_label.text = "LUK XP" + "["+str(player.exp_handler.get_luk_current_xp())+"/"+str(player.exp_handler.get_luk_needed_xp())+"]"
		luk_xp_progressbar.max_value = player.exp_handler.get_luk_needed_xp()
		luk_xp_progressbar.value = player.exp_handler.get_luk_current_xp()
		XP_menu.show()
	else:
		XP_menu.hide()


func _on_menu_button_pressed():
	xp_menu_show = !xp_menu_show

func _on_secondary_stats_button_pressed() -> void:
	secondary_stats_panel_show = !secondary_stats_panel_show
