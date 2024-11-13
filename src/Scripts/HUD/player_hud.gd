extends Control

#player description labels
@onready var level_label : Label = $HUD/HBoxContainer/PlayerDescriptionMargin/PlayerDescriptionBox/HBoxContainer/LevelLabel
@onready var player_class_label : Label = $HUD/HBoxContainer/PlayerDescriptionMargin/PlayerDescriptionBox/HBoxContainer/MarginContainer/PlayerNames/PlayerClass
@onready var player_name_label : Label = $HUD/HBoxContainer/PlayerDescriptionMargin/PlayerDescriptionBox/HBoxContainer/MarginContainer/PlayerNames/PlayerName

#stat bar stuff
#HP Bar
@onready var hit_points_label : Label = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/HPBar/HitPointsLabel
@onready var hp_bar : ProgressBar = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/HPBar/HPBar
#MP Bar
@onready var magic_points_label : Label = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/MPBar/MagicPointsLabel
@onready var mp_bar : ProgressBar = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/MPBar/MPBar
#XP Bar
@onready var experience_points_label : Label = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/XPBar/XPPointsLabel
@onready var xp_bar : ProgressBar = $HUD/HBoxContainer/StatBarsMargin/StatBars/BarsMargin/Bars/XPBar/XPBar


#Pause Menu Button
@onready var menu_button : Button = $HUD/HBoxContainer/MiscMargin/Misc/MenuButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hp_bar.add_theme_color_override("fill", Color.RED)
	mp_bar.add_theme_color_override("fill", Color.BLUE)
	xp_bar.add_theme_color_override("fill", Color.GOLD)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Player Description Displayers
	level_label.text = "Level " + str(GameManager.get_player_current_level())
	player_class_label.text = GameManager.get_player_class()
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
	experience_points_label.text = "XP " + "["+str(GameManager.get_player_current_xp())+"/"+str(GameManager.get_player_xp_needed())+"]"
	xp_bar.max_value = GameManager.get_player_xp_needed()
	xp_bar.value = GameManager.get_player_current_xp()
	
	
