extends Control

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

var xp_menu_show
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	xp_menu_show = false
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Player Description Displayers
	level_label.text = "Total Level " + str(GameManager.get_player_total_level())
	player_name_label.text = GameManager.get_player_name()
	#HP Displayers
	hit_points_label.text = "HP " + "["+str(GameManager.get_player_current_health())+"/"+str(GameManager.get_player_max_health())+"]"
	hp_bar.max_value = GameManager.get_player_max_health()
	hp_bar.value = GameManager.get_player_current_health()
	#MP Displayers
	magic_points_label.text = "MP " + "["+str(GameManager.get_player_current_magic_points())+"/"+str(GameManager.get_player_magic_points())+"]"
	mp_bar.max_value = GameManager.get_player_magic_points()
	mp_bar.value = GameManager.get_player_current_magic_points()
	
	#XP Displayers
	#STR Display
	str_xp_label.text = "STR XP" + "["+str(GameManager.get_player_str_current_xp())+"/"+str(GameManager.get_player_str_xp_needed())+"]"
	str_xp_progressbar.max_value = GameManager.get_player_str_xp_needed()
	str_xp_progressbar.value = GameManager.get_player_str_current_xp()
	#DEX Display
	dex_xp_label.text = "DEX XP" + "["+str(GameManager.get_player_dex_current_xp())+"/"+str(GameManager.get_player_dex_xp_needed())+"]"
	dex_xp_progressbar.max_value = GameManager.get_player_dex_xp_needed()
	dex_xp_progressbar.value = GameManager.get_player_dex_current_xp()
	#INT Display
	int_xp_label.text = "INT XP" + "["+str(GameManager.get_player_int_current_xp())+"/"+str(GameManager.get_player_int_xp_needed())+"]"
	int_xp_progressbar.max_value = GameManager.get_player_int_xp_needed()
	int_xp_progressbar.value = GameManager.get_player_int_current_xp()
	#LUK Display
	luk_xp_label.text = "LUK XP" + "["+str(GameManager.get_player_luk_current_xp())+"/"+str(GameManager.get_player_luk_xp_needed())+"]"
	luk_xp_progressbar.max_value = GameManager.get_player_luk_xp_needed()
	luk_xp_progressbar.value = GameManager.get_player_luk_current_xp()
	
	if xp_menu_show == true:
		XP_menu.show()
	else:
		XP_menu.hide()


func _on_menu_button_pressed():
	xp_menu_show = !xp_menu_show
	
