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
#MINING XP
@onready var min_xp_label : Label = $SkillsXPMenu/VBoxContainer/MINXP_Label
@onready var min_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/MINXP_ProgressBar
#SMELTING XP
@onready var smt_xp_label : Label = $SkillsXPMenu/VBoxContainer/SMTXP_Label
@onready var smt_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/SMTXP_ProgressBar
#CRAFTING XP
@onready var crf_xp_label : Label = $SkillsXPMenu/VBoxContainer/CRFXP_Label
@onready var crf_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/CRFXP_ProgressBar
#WOODCUTTING XP
@onready var wc_xp_label : Label = $SkillsXPMenu/VBoxContainer/WCXP_Label
@onready var wc_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/WCXP_ProgressBar
#FIREMAKING XP
@onready var fm_xp_label : Label = $SkillsXPMenu/VBoxContainer/FMXP_Label
@onready var fm_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/FMXP_ProgressBar
#COOKING XP
@onready var cook_xp_label : Label = $SkillsXPMenu/VBoxContainer/CKXP_Label
@onready var cook_xp_progressbar : ProgressBar = $SkillsXPMenu/VBoxContainer/CKXP_ProgressBar
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
@onready var mining_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/MINLvl
@onready var refinery_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/SmtLvl
@onready var crafting_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/CRFLVL
@onready var wood_cutting_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/WCLvl
@onready var fire_making_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/FMGLvl
@onready var cooking_lvl : Label = $StatsPanel/AbilityLevels/VBoxContainer/CKLvl
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
@onready var inventory : PlayerInventory = $Inventory
@onready var equipped_panel : EquippedGearPanel = $EquippedGearPanel
var xp_menu_show
var stats_panel_show
var secondary_stats_panel_show
var inventory_show
var equipped_panel_show
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory_show = false
	xp_menu_show = false
	stats_panel_show = false
	secondary_stats_panel_show = false
	equipped_panel_show = false
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Player Description Displayers
	level_label.text = "Total Level " + str(player.stats_resource.get_total_level())
	player_name_label.text = player.stats_resource.name
	#HP Displayers
	hit_points_label.text = "HP " + "["+str(player.stats_resource.current_health)+"/"+str(player.stats_resource.max_health)+"]"
	hp_bar.max_value = player.stats_resource.max_health
	hp_bar.value = player.stats_resource.current_health
	#MP Displayers
	magic_points_label.text = "MP " + "["+str(player.stats_resource.current_magic_points)+"/"+str(player.stats_resource.magic_points)+"]"
	mp_bar.max_value = player.stats_resource.magic_points
	mp_bar.value = player.stats_resource.current_magic_points
	
	if Input.is_action_just_pressed("stats"):
		stats_panel_show = !stats_panel_show
	
	if Input.is_action_just_pressed("inventory"):
		inventory_show = !inventory_show
	
	if Input.is_action_just_pressed("equipped"):
		equipped_panel_show = !equipped_panel_show
	
	if equipped_panel_show:
		equipped_panel.show()
	else:
		equipped_panel.hide()
	
	if inventory_show:
		inventory.show()
	else:
		inventory.hide()
	
	#Displays primary stats when toggled
	if stats_panel_show:
		name_label.text = "Name: " + player.stats_resource.name
		if player.equipped_weapon:
			equipped_archetype.text = "Equipped Archetype: " + str(player.equipped_weapon.get_archetype_class_name())
		else:
			equipped_archetype.text = "No Weapon Equipped"
		total_level.text = "Total Level: " + str(player.stats_resource.get_total_level())
		#total exp needed
		HP.text = "HP: "+"["+str(player.stats_resource.current_health)+"/"+str(player.stats_resource.max_health)+"]"
		MP.text = "MP: "+"["+str(player.stats_resource.current_magic_points)+"/"+str(player.stats_resource.magic_points)+"]"
		str_lvl.text = "STR LVL: " + str(player.stats_resource.str_level)
		dex_lvl.text = "DEX LVL: " + str(player.stats_resource.dex_level)
		int_lvl.text = "INT LVL: " + str(player.stats_resource.int_level)
		luk_lvl.text = "LUK LVL: " + str(player.stats_resource.luk_level)
		mining_lvl.text = "MNG LVL: " + str(player.stats_resource.mining_level)
		refinery_lvl.text = "REF LVL: " + str(player.stats_resource.smelting_level)
		crafting_lvl.text = "CRF LVL: " + str(player.stats_resource.crafting_level)
		wood_cutting_lvl.text = "WCG LVL: " + str(player.stats_resource.wood_cutting_level)
		fire_making_lvl.text = "FMG Lvl: " + str(player.stats_resource.fire_making_level)
		cooking_lvl.text = "CKG LVL: " + str(player.stats_resource.cooking_level)
		stats_panel.show()
	else:
		stats_panel.hide()
	
	#Displays secondary stats when toggled
	if secondary_stats_panel_show:
		if player.equipped_weapon:
			p_atk.text = "Weapon Attack: " + str(player.stats_resource.get_min_weapon_attack()) +" ~ " + str(player.stats_resource.get_max_weapon_attack())
			m_atk.text = "Magic Attack: " + str(player.stats_resource.get_min_magic_attack()) + " ~ " +str(player.stats_resource.get_max_magic_attack())
			s_atk.text = "Shadow Attack: " + str(player.stats_resource.get_min_shadow_attack()) + " ~ " + str(player.stats_resource.get_max_shadow_attack())
			w_def.text = "Weapon Defense: " + str(player.equipped_weapon.get_weapon_defense())
			m_def.text = "Magic Defense: " + str(player.equipped_weapon.get_weapon_magic_defense())
			s_def.text = "Shadow Defense: " + str(player.equipped_weapon.get_weapon_shadow_defense())
		else:
			p_atk.text = "Weapon Attack: 0" 
			m_atk.text = "Magic Attack: 0" 
			s_atk.text = "Shadow Attack: 0" 
			w_def.text = "Weapon Defense: 0" 
			m_def.text = "Magic Defense: 0"
			s_def.text = "Shadow Defense: 0"
		acc.text = "Accuracy: " + str(player.stats_resource.accuracy)
		avoid.text = "Avoidability: " +str(player.stats_resource.avoidability)
		speed.text = "Speed: " + str(player.stats_resource.speed)
		jump.text = "Jump: " + str(player.stats_resource.jump) 
		secondary_stats_panel.show()
	else:
		secondary_stats_panel.hide()
	
	if xp_menu_show:
		#XP Displayers
		#STR Display
		str_xp_label.text = "STR XP" + "["+str(player.stats_resource.get_str_current_xp())+"/"+str(player.stats_resource.get_str_needed_xp())+"]"
		str_xp_progressbar.max_value = player.stats_resource.get_str_needed_xp()
		str_xp_progressbar.value = player.stats_resource.get_str_current_xp()
		#DEX Display
		dex_xp_label.text = "DEX XP" + "["+str(player.stats_resource.get_dex_current_xp())+"/"+str(player.stats_resource.get_dex_needed_xp())+"]"
		dex_xp_progressbar.max_value = player.stats_resource.get_dex_needed_xp()
		dex_xp_progressbar.value = player.stats_resource.get_dex_current_xp()
		#INT Display
		int_xp_label.text = "INT XP" + "["+str(player.stats_resource.get_int_current_xp())+"/"+str(player.stats_resource.get_int_needed_xp())+"]"
		int_xp_progressbar.max_value = player.stats_resource.get_int_needed_xp()
		int_xp_progressbar.value = player.stats_resource.get_int_current_xp()
		#LUK Display
		luk_xp_label.text = "LUK XP" + "["+str(player.stats_resource.get_luk_current_xp())+"/"+str(player.stats_resource.get_luk_needed_xp())+"]"
		luk_xp_progressbar.max_value = player.stats_resource.get_luk_needed_xp()
		luk_xp_progressbar.value = player.stats_resource.get_luk_current_xp()
		#MINING Display
		min_xp_label.text = "MINING XP" + "["+str(player.stats_resource.get_mining_current_xp())+"/"+str(player.stats_resource.get_mining_needed_xp())+"]"
		min_xp_progressbar.max_value = player.stats_resource.get_mining_needed_xp()
		min_xp_progressbar.value = player.stats_resource.get_mining_current_xp()
		#SMELTING Display
		smt_xp_label.text = "SMELTING XP" + "["+str(player.stats_resource.get_smelting_current_xp())+"/"+str(player.stats_resource.get_smelting_needed_xp())+"]"
		smt_xp_progressbar.max_value = player.stats_resource.get_smelting_needed_xp()
		smt_xp_progressbar.value = player.stats_resource.get_smelting_current_xp()
		#CRAFTING Display
		crf_xp_label.text = "CRAFTING XP" + "["+str(player.stats_resource.get_crafting_current_xp())+"/"+str(player.stats_resource.get_crafting_needed_xp())+"]"
		crf_xp_progressbar.max_value = player.stats_resource.get_crafting_needed_xp()
		crf_xp_progressbar.value = player.stats_resource.get_crafting_current_xp()
		#WOODCUTTING Display
		wc_xp_label.text = "WOODCUTTING XP" + "["+str(player.stats_resource.get_woodcutting_current_xp())+"/"+str(player.stats_resource.get_woodcutting_needed_xp())+"]"
		wc_xp_progressbar.max_value = player.stats_resource.get_woodcutting_needed_xp()
		wc_xp_progressbar.value = player.stats_resource.get_woodcutting_current_xp()
		#FIREMAKING Display
		fm_xp_label.text = "FIREMAKING XP" + "["+str(player.stats_resource.get_firemaking_current_xp())+"/"+str(player.stats_resource.get_firemaking_needed_xp())+"]"
		fm_xp_progressbar.max_value = player.stats_resource.get_firemaking_needed_xp()
		fm_xp_progressbar.value = player.stats_resource.get_firemaking_current_xp()
		#COOKING Display
		cook_xp_label.text = "COOKING XP" + "["+str(player.stats_resource.get_cooking_current_xp())+"/"+str(player.stats_resource.get_cooking_needed_xp())+"]"
		cook_xp_progressbar.max_value = player.stats_resource.get_cooking_needed_xp()
		cook_xp_progressbar.value = player.stats_resource.get_cooking_current_xp()
		XP_menu.show()
	else:
		XP_menu.hide()


func _on_menu_button_pressed():
	xp_menu_show = !xp_menu_show

func _on_secondary_stats_button_pressed() -> void:
	secondary_stats_panel_show = !secondary_stats_panel_show
