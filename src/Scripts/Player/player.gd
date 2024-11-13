extends Entity

@export
var jump_force := 300
@export
var hit_box_x_pos : float
var has_jumped := false
var in_ladder_area := false
@onready
var hitbox : Area2D = $HitBox
@onready
var hitbox_collision: CollisionShape2D = $HitBox/CollisionShape2D
@onready
var player_name : Label = $PlayerName
#@onready
#var camera := $Camera2D
@onready
var health_component : HealthComponent = $HealthComponent
@onready
var health_tracker : Label = $HealthTracker
@onready
var stats_component : StatsComponent = $StatsComponent
@onready
var damage_taken_tracker : Label = $DamageTaken
# Called when the node enters the scene tee for the first time.
func _ready() -> void:

	_set_stats()
	state_machine.init(self)

func _process(delta):
	stats_component.set_player_str_current_xp()
	stats_component.set_player_dex_current_xp()
	stats_component.set_player_int_current_xp()
	stats_component.set_player_luk_current_xp()
	stats_component.set_current_health(GameManager.get_player_current_health())
	stats_component.set_current_magic_points(GameManager.get_player_current_magic_points())

func _on_area_2d_body_entered(body):
	self.in_ladder_area = true

func _on_area_2d_body_exited(body):
	self.in_ladder_area = false

func _on_hurt_box_area_entered(hitbox : HitBox) -> void:
	was_hit = true
	enemy_hitbox_parent = hitbox.get_parent()
	health_component.apply_damage(enemy_hitbox_parent.stats_component.get_minimum_physical_attack(), enemy_hitbox_parent.stats_component.get_maximum_physical_attack())

func _set_stats() -> void:
	#set player name, first off
	player_name.text = GameManager.get_player_name()
	#Level
	GameManager.set_player_total_level()
	stats_component.set_total_level(GameManager.get_player_total_level())
	#XP
	#calculate all necessary stuff
	GameManager.calculate_needed_stat_xp("str_level", "str_needed_xp")
	GameManager.calculate_needed_stat_xp("dex_level", "dex_needed_xp")
	GameManager.calculate_needed_stat_xp("int_level", "int_needed_xp")
	GameManager.calculate_needed_stat_xp("luk_level", "luk_needed_xp")
	
	#set needed XP values -- current values are set in process
	stats_component.set_player_str_xp_needed()
	stats_component.set_player_dex_xp_needed()
	stats_component.set_player_int_xp_needed()
	stats_component.set_player_luk_xp_needed()
	#HP
	stats_component.set_max_health(GameManager.get_player_max_health())
	stats_component.set_current_health(GameManager.get_player_current_health())
	#MP
	stats_component.set_magic_points(GameManager.get_player_magic_points())
	stats_component.set_current_magic_points(GameManager.get_player_current_magic_points())

	#Core Stats
	stats_component.set_strength(GameManager.get_player_current_strength_level())
	stats_component.set_dexterity(GameManager.get_player_current_dexterity_level())
	stats_component.set_intelligence(GameManager.get_player_current_intelligence_level())
	stats_component.set_luck(GameManager.get_player_current_luck_level())
	#Calculate base min/max damage
	stats_component.calculate_minimum_physical_attack(GameManager.get_player_strength(), GameManager.get_player_dexterity(), 2)
	stats_component.calculate_maximum_physical_attack(GameManager.get_player_strength(), GameManager.get_player_dexterity(), 2)
	#Calculate weapon defense
	stats_component.calculate_weapon_defense(17)
	
