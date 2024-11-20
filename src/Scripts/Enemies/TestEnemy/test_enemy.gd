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

@export
var stats_resource : Stats
@export
var equipped_weapon : Weapon
@onready
var health_bar : ProgressBar = $ProgressBar
@onready
var item_holder : ItemHolder = $ItemHolder
func _ready() -> void:
	#health_bar.max_value = stats_component.get_max_health()
	StatCalculations.init_necessary_stat_calculations(stats_resource, equipped_weapon)
	print_debug(equipped_weapon.name)
	#stats_component.calculate_minimum_physical_attack(stats_component.get_strength(), 0, 4)
	#stats_component.calculate_maximum_physical_attack(stats_component.get_strength(), 0, 4)
	#stats_component.calculate_weapon_defense(stats_component.get_weapon_defense())
	state_machine.init(self)
	
func _on_player_detector_body_entered(body : CharacterBody2D):
	if body is Player:
		timer.wait_time = 4
		player = body
		player_seen = true

func _on_attack_range_body_entered(body : CharacterBody2D):
	if body is Player:
		can_attack = true

func _on_attack_range_body_exited(body : CharacterBody2D):
	if body is Player:
		can_attack = false

func _on_player_detector_body_exited(body):
	if body is Player:
		timer.start()
		player_seen = false

func _on_hurt_box_area_entered(hitbox : HitBox) -> void:
	was_hit = true
	player = hitbox.get_parent()
	health_component.apply_damage(player.stats_resource, player.equipped_weapon)

# Function to spawn an item
func spawn_item():
	var item_drop = ItemInteractable.new()
	item_drop.item_data = item_holder.items[0]
	item_drop.global_position = self.global_position + Vector2(randf_range(-10, 10), randf_range(-10, 10))
	item_drop.z_index = 999
	get_tree().current_scene.add_child(item_drop)
	print("Item created at position: ", item_drop.global_position)
	print("In instance: ", get_tree().current_scene)

# Function to spawn currency
func spawn_currency():
	var coin_drop : CurrencyInteractable = CurrencyInteractable.new()
	var drop_icon = Sprite2D.new()
	drop_icon.texture = preload("res://Assets/Coin.png")
	coin_drop.icon = drop_icon
	coin_drop.min_value = item_holder.min_currency_value
	coin_drop.max_value = item_holder.max_currency_value
	coin_drop.z_index = 999
	coin_drop.global_position = self.global_position + Vector2(randf_range(-10, 10), randf_range(-10, 10))
	get_tree().current_scene.add_child(coin_drop)
	print("Item created at position: ", coin_drop.global_position)
