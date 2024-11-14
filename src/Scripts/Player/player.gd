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
var damage_taken_tracker : Label = $DamageTaken
# Called when the node enters the scene tee for the first time.
func _ready() -> void:
	_set_stats()
	state_machine.init(self)

func _process(delta):
	PlayerManager.track_for_excess_xp()
	pass

func _on_area_2d_body_entered(body):
	self.in_ladder_area = true

func _on_area_2d_body_exited(body):
	self.in_ladder_area = false

func _on_hurt_box_area_entered(hitbox : HitBox) -> void:
	was_hit = true
	enemy_hitbox_parent = hitbox.get_parent()
	health_component.apply_damage(enemy_hitbox_parent.stats_component.get_minimum_physical_attack(), enemy_hitbox_parent.stats_component.get_maximum_physical_attack())

func _set_stats():
	player_name.text = PlayerManager.get_player_name()
	PlayerManager.set_up_min_max_attack()
	PlayerManager.calculate_weapon_defense()
	PlayerManager.calculate_magic_defense()
	PlayerManager.calculate_needed_stat_xp("str_level", "str_needed_xp")
	PlayerManager.calculate_needed_stat_xp("dex_level", "dex_needed_xp")
	PlayerManager.calculate_needed_stat_xp("int_level", "int_needed_xp")
	PlayerManager.calculate_needed_stat_xp("luk_level", "luk_needed_xp")
