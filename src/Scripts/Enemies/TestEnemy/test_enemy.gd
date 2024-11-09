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

func _ready() -> void:
	state_machine.init(self)
	
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
	print("I WAS HIT!")
	health_component.apply_damage(hitbox.min_damage, hitbox.max_damage)
