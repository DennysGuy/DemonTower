extends Entity

var player_seen = false
var player
@export
var hit_box_x_pos : float = 25
@onready
var timer : Timer = $Timer
@onready
var health_component : HealthComponent = $HealthComponent
@onready
var health_tracker : Label = $Label
@onready
var stats_component : StatsComponent = $StatsComponent
@onready
var health_bar : ProgressBar = $ProgressBar

func _ready() -> void:
	health_bar.max_value = stats_component.get_max_health()
	
	stats_component.calculate_minimum_attack(stats_component.get_strength(), stats_component.get_dexterity(), 1.2, 4)
	stats_component.calculate_maximum_attack(stats_component.get_strength(), stats_component.get_dexterity(), 1.2, 4)
	stats_component.calculate_weapon_defense(stats_component.get_weapon_defense())
	state_machine.init(self)

func _process(delta):
	health_bar.value = stats_component.get_current_health()
	
func _on_player_detector_body_entered(body : CharacterBody2D):
	if body.name == "Player":
		timer.wait_time = 5
		player = body
		player_seen = true

func _on_attack_range_body_entered(body : CharacterBody2D):
	if body.name == "Player":
		can_attack = true

func _on_attack_range_body_exited(body : CharacterBody2D):
	if body.name == "Player":
		can_attack = false

func _on_player_detector_body_exited(body):
	if body.name =="Player":
		timer.start()
		player_seen = false

func _on_hurt_box_area_entered(hitbox : HitBox) -> void:
	was_hit = true
	enemy_hitbox_parent = hitbox.get_parent()
	health_component.apply_damage(enemy_hitbox_parent.stats_component.get_minimum_attack(), enemy_hitbox_parent.stats_component.get_maximum_attack())
