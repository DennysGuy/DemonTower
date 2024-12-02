class_name Player extends Entity

@export var stats_resource : Stats
@export var equipped_weapon : Weapon
@export var coin_purse : Area2D

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

var enemy : Entity
# Called when the node enters the scene tee for the first time.
func _ready() -> void:
	
	_set_stats()
	Inventory.equip_gear("weapon", load("res://src/Resources/Items/Weapons/Archetypes/Warrior/SwordShields/01_Common/WoodSwordShield.tres"))
	state_machine.init(self)

func _process(delta):
	#PlayerManager.track_for_excess_xp()
	equipped_weapon = Inventory.inventories["equipped_gear"]["weapon"]
	if equipped_weapon:
		StatCalculations.init_necessary_stat_calculations(stats_resource, equipped_weapon)
	ExpHandlers.track_xp_for_roll_over(stats_resource)

func _on_area_2d_body_entered(body):
	self.in_ladder_area = true

func _on_area_2d_body_exited(body):
	self.in_ladder_area = false

func _on_hurt_box_area_entered(hitbox : HitBox) -> void:
	was_hit = true
	enemy = hitbox.get_parent()
	health_component.apply_damage(enemy.stats_resource, enemy.equipped_weapon)

func _set_stats():
	player_name.text = stats_resource.name
	ExpHandlers.calculate_total_level(stats_resource)
	if equipped_weapon:
		ExpHandlers.init_needed_xp_for_all_stats(stats_resource)
	stats_resource.max_health = stats_resource.max_health + equipped_weapon.HP_bonus #this will need to be set whenever player changes weapon
	stats_resource.current_health = stats_resource.max_health #will be removed during final setup

func apply_received_xp(value : int) -> void:
	match(equipped_weapon.archetype_class):
		equipped_weapon.ArchetypeClass.WARRIOR:
			var str_level = stats_resource.str_level
			var current_str_xp = stats_resource.get_str_current_xp()
			var needed_str_xp = stats_resource.get_str_needed_xp()
			stats_resource.set_str_current_xp(current_str_xp+value)
		equipped_weapon.ArchetypeClass.MAGE:
			var int_level = stats_resource.int_level
			var current_int_xp = stats_resource.get_int_current_xp()
			var needed_int_xp = stats_resource.get_int_needed_xp()
			stats_resource.set_int_current_xp(current_int_xp+value)
		equipped_weapon.ArchetypeClass.ROGUE:
			var dex_level = stats_resource.dex_level
			var current_dex_xp = stats_resource.get_dex_current_xp()
			var needed_dex_xp = stats_resource.get_dex_needed_xp()
			
			var luk_level = stats_resource.luk_level
			var current_luk_xp = stats_resource.get_luk_current_xp()
			var needed_luk_xp = stats_resource.get_luk_needed_xp()
			match(equipped_weapon.weapon_class):
				equipped_weapon.WeaponClass.KNIVES:
					stats_resource.set_luk_current_xp(current_luk_xp+value)
					stats_resource.set_dex_current_xp(current_dex_xp+int(value/4))
				equipped_weapon.WeaponClass.CLAW:
					stats_resource.set_dex_current_xp(current_dex_xp+value)
					stats_resource.set_luk_current_xp(current_luk_xp+int(value/4))
	ExpHandlers.track_xp_for_roll_over(stats_resource)
