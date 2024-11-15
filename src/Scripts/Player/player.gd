class_name Player extends Entity

@export var player_stats : Stats
@export var equipped_weapon : Weapon
@export var stat_calculations : StatCalculations
@export var exp_handler : EXPHandler

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
var damage_taken_tracker : Label = $DamageTaken
# Called when the node enters the scene tee for the first time.
func _ready() -> void:
	stat_calculations.stats_resource = player_stats
	stat_calculations.equipped_weapon = equipped_weapon
	stat_calculations.init_necessary_stat_calculations()
	exp_handler.stats_resource = player_stats
	exp_handler.equipped_weapon = equipped_weapon
	_set_stats()
	state_machine.init(self)

func _process(delta):
	#PlayerManager.track_for_excess_xp()
	exp_handler.track_xp_for_roll_over()

func _on_area_2d_body_entered(body):
	self.in_ladder_area = true

func _on_area_2d_body_exited(body):
	self.in_ladder_area = false

func _on_hurt_box_area_entered(hitbox : HitBox) -> void:
	was_hit = true
	enemy_hitbox_parent = hitbox.get_parent()
	health_component.apply_damage(enemy_hitbox_parent.stats_component.get_minimum_physical_attack(), enemy_hitbox_parent.stats_component.get_maximum_physical_attack())

func _set_stats():
	player_name.text = player_stats.name
	exp_handler.calculate_total_level()
	exp_handler.init_needed_xp_for_all_stats()
	player_stats.max_health = player_stats.max_health + equipped_weapon.HP_bonus #this will need to be set whenever player changes weapon
	player_stats.current_health = player_stats.max_health #will be removed during final setup
