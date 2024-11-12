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
# Called when the node enters the scene tee for the first time.
func _ready() -> void:
	state_machine.init(self)

func _process(delta):
	_set_stats()

func _on_area_2d_body_entered(body):
	self.in_ladder_area = true

func _on_area_2d_body_exited(body):
	self.in_ladder_area = false

func _on_hurt_box_area_entered(hitbox : HitBox) -> void:
	was_hit = true
	enemy_hitbox_parent = hitbox.get_parent()
	health_component.apply_damage(enemy_hitbox_parent.stats_component.get_minimum_attack(), enemy_hitbox_parent.stats_component.get_maximum_attack())

func _set_stats() -> void:
	#set player name, first off
	player_name.text = GameManager.get_player_name()
	#Level
	stats_component.set_level(GameManager.get_current_level())
	#HP
	stats_component.set_max_health(GameManager.get_max_health())
	stats_component.set_current_health(GameManager.get_current_health())
	#MP
	stats_component.set_magic_points(GameManager.get_magic_points())
	stats_component.set_current_magic_points(GameManager.get_current_magic_points())
	#XP
	stats_component.set_xp_needed(GameManager.get_xp_needed())
	stats_component.set_current_xp(GameManager.get_current_xp())
	#Core Stats
	stats_component.set_strength(GameManager.get_strength())
	stats_component.set_dexterity(GameManager.get_dexterity())
	stats_component.set_intelligence(GameManager.get_intelligence())
	stats_component.set_luck(GameManager.get_luck())
	#Calculate base min/max damage
	stats_component.calculate_minimum_attack(GameManager.get_strength(), GameManager.get_dexterity(), 1.2, 4)
	stats_component.calculate_maximum_attack(GameManager.get_strength(), GameManager.get_dexterity(), 1.2, 4)
	#Calculate weapon defense
	stats_component.calculate_weapon_defense(17)
