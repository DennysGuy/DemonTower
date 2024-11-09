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
# Called when the node enters the scene tee for the first time.
func _ready() -> void:
	player_name.text = GameManager.character_name
	state_machine.init(self)

func _on_area_2d_body_entered(body):
	self.in_ladder_area = true

func _on_area_2d_body_exited(body):
	self.in_ladder_area = false

func _on_hurt_box_area_entered(hitbox : HitBox) -> void:
	was_hit = true
	enemy_hitbox_parent = hitbox.get_parent()
	health_component.apply_damage(hitbox.min_damage, hitbox.max_damage)
