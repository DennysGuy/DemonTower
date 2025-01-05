class_name Player extends Entity

@export var stats_resource : Stats
@export var equipped_weapon : Weapon
@export var coin_purse : Area2D

@onready var player_animations : AnimationPlayer = $AnimationPlayer

#player parts
#shield
@onready var shield : Sprite2D = $PlayerParts/Shield
#Left Arm 
@onready var left_arm : Sprite2D = $PlayerParts/LeftUpperBody/LeftArm
@onready var left_shirt_sleeve : Sprite2D = $PlayerParts/LeftUpperBody/LeftShirtSleeve
@onready var left_glove : Sprite2D = $PlayerParts/LeftUpperBody/LeftGlove
#UpperMiddleBody
@onready var cape : Sprite2D = $PlayerParts/UpperMiddleBody/Cape
@onready var torso : Sprite2D = $PlayerParts/UpperMiddleBody/Torso
@onready var shirt_torso : Sprite2D = $PlayerParts/UpperMiddleBody/ShirtTorso
#LowerBody
@onready var legs : Sprite2D = $PlayerParts/LowerBody/Legs
@onready var pants : Sprite2D = $PlayerParts/LowerBody/Pants
@onready var bottoms : Sprite2D = $PlayerParts/LowerBody/Bottoms
#RightUpperBody
@onready var sword : Sprite2D = $PlayerParts/RightUpperBody/Sword
@onready var right_arm : Sprite2D = $PlayerParts/RightUpperBody/RightArm
@onready var right_shirt_sleeve : Sprite2D = $PlayerParts/RightUpperBody/RightShirtSleeve
@onready var right_glove : Sprite2D = $PlayerParts/RightUpperBody/RightGlove
#UpperBody
@onready var head : Sprite2D = $PlayerParts/UpperBody/Head
@onready var eyes : Sprite2D = $PlayerParts/UpperBody/Eyes
@onready var hair : Sprite2D = $PlayerParts/UpperBody/Hair
#OnClimb
@onready var cape_on_climb : Sprite2D= $PlayerParts/OnClimb/CapeOnClimb
@onready var weapon_on_climb : Sprite2D = $PlayerParts/OnClimb/WeaponOnClimb
#Effects
@onready var effects = $PlayerParts/Effects

var texture_parts : Array[Sprite2D]

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
var selected_animations : Array

const animation_names : Dictionary = {
	"Standard" : ["Idle","Climb", "Hit", "Die", "Run", "Jump", "Fall"],
	"Sword and Shield" : ["Idle","Climb", "Hit", "Die", "Run", "Equip_Jump", "Equip_Fall", "SwordShield_Attack1", "SwordShield_Attack2", "SwordShield_Attack3"]
}
var weapon_type : String
var enemy : Entity
# Called when the node enters the scene tee for the first time.
func _ready() -> void:
	_set_stats()
	if equipped_weapon == null:
		weapon_type = "Standard"
	else:
		weapon_type = equipped_weapon.get_weapon_type_name()
		
	texture_parts = [left_arm, left_shirt_sleeve, left_glove, cape, torso, shirt_torso, legs, pants, bottoms, sword, right_arm, right_shirt_sleeve, right_glove, head,eyes,hair,sword,shield,effects]
	selected_animations = animation_names[weapon_type]
	#Inventory.equip_gear("weapon", load("res://src/Resources/Items/Weapons/Archetypes/Warrior/SwordShields/01_Common/WoodSwordShield.tres"))
	state_machine.init(self)

func _process(delta):
	#PlayerManager.track_for_excess_xp()
	#print(weapon_type)
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

func play_animation(index : int) -> void:
	player_animations.play(selected_animations[index])

func flip_textures(flip : bool) -> void:
	for sprite in texture_parts:
		sprite.flip_h = flip

func standardize_animations():
	weapon_type = "Standard"
	selected_animations = animation_names[weapon_type]

func set_weapon(type : String, weapon : Weapon):
	equipped_weapon = weapon
	if equipped_weapon == null:
		weapon_type = "Standard"
	else:
		weapon_type = equipped_weapon.get_weapon_type_name()
	selected_animations = animation_names[weapon_type]

func set_textures(state : String) -> void:
	var equipped_shirt = Inventory.inventories["equipped_gear"]["shirt"]
	var equipped_gloves = Inventory.inventories["equipped_gear"]["gloves"]
	var equipped_pants = Inventory.inventories["equipped_gear"]["pants"]
	var equipped_shoes = Inventory.inventories["equipped_gear"]["shoes"]

	if equipped_shirt != null:
		left_shirt_sleeve.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shirt"][equipped_shirt.texture_index]["Left Sleeve"]
		shirt_torso.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shirt"][equipped_shirt.texture_index]["Torso Shirt"]
		right_shirt_sleeve.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shirt"][equipped_shirt.texture_index]["Right Sleeve"]
	if equipped_gloves != null:
		left_glove.texture = PlayerTextures.texture_atlas[weapon_type][state]["Gloves"]["Left Glove"][equipped_gloves.texture_index]
		right_glove.texture = PlayerTextures.texture_atlas[weapon_type][state]["Gloves"]["Right Glove"][equipped_gloves.texture_index]
	if equipped_pants != null:
		pants.texture = PlayerTextures.texture_atlas[weapon_type][state]["Pants"][equipped_pants.texture_index]
	if equipped_shoes != null:
		bottoms.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shoes"][equipped_shoes.texture_index]
	if equipped_weapon:
		if weapon_type == "Sword and Shield":
			sword.texture = PlayerTextures.texture_atlas[weapon_type][state]["Sword"][equipped_weapon.texture_index]
			shield.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shield"][equipped_weapon.texture_index]
			if "Attack" in state:
				effects.texture = PlayerTextures.texture_atlas[weapon_type][state]["Effect"][0]
	
	cape.texture = PlayerTextures.texture_atlas[weapon_type][state]["Cape"][0]
	
	torso.texture = PlayerTextures.texture_atlas[weapon_type][state]["Torso"][0]
	left_arm.texture = PlayerTextures.texture_atlas[weapon_type][state]["Left Arm"][0]
	right_arm.texture = PlayerTextures.texture_atlas[weapon_type][state]["Right Arm"][0]
	legs.texture = PlayerTextures.texture_atlas[weapon_type][state]["Legs"][0]
	#sword.textures
	head.texture = PlayerTextures.texture_atlas[weapon_type][state]["Head"][0]
	eyes.texture = PlayerTextures.texture_atlas[weapon_type][state]["Eyes"]["Green"][0]
	hair.texture = PlayerTextures.texture_atlas[weapon_type][state]["Hair"]["Black"][0]

func set_textures_on_climb(state):
	var equipped_shirt = Inventory.inventories["equipped_gear"]["shirt"]
	var equipped_gloves = Inventory.inventories["equipped_gear"]["gloves"]
	var equipped_pants = Inventory.inventories["equipped_gear"]["pants"]
	var equipped_shoes = Inventory.inventories["equipped_gear"]["shoes"]

	if equipped_shirt != null:
		left_shirt_sleeve.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shirt"][equipped_shirt.texture_index]["Left Sleeve"]
		shirt_torso.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shirt"][equipped_shirt.texture_index]["Torso Shirt"]
		right_shirt_sleeve.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shirt"][equipped_shirt.texture_index]["Right Sleeve"]
	if equipped_gloves != null:
		left_glove.texture = PlayerTextures.texture_atlas[weapon_type][state]["Gloves"]["Left Glove"][equipped_gloves.texture_index]
		right_glove.texture = PlayerTextures.texture_atlas[weapon_type][state]["Gloves"]["Right Glove"][equipped_gloves.texture_index]
	if equipped_pants != null:
		pants.texture = PlayerTextures.texture_atlas[weapon_type][state]["Pants"][equipped_pants.texture_index]
	if equipped_shoes != null:
		bottoms.texture = PlayerTextures.texture_atlas[weapon_type][state]["Shoes"][equipped_shoes.texture_index]
	

	cape.texture = PlayerTextures.texture_atlas[weapon_type][state]["Cape"][0]
	
	torso.texture = PlayerTextures.texture_atlas[weapon_type][state]["Torso"][0]
	left_arm.texture = PlayerTextures.texture_atlas[weapon_type][state]["Left Arm"][0]
	right_arm.texture = PlayerTextures.texture_atlas[weapon_type][state]["Right Arm"][0]
	legs.texture = PlayerTextures.texture_atlas[weapon_type][state]["Legs"][0]
	#sword.textures
	head.texture = PlayerTextures.texture_atlas[weapon_type][state]["Head"][0]
	eyes.texture = PlayerTextures.texture_atlas[weapon_type][state]["Eyes"]["Green"][0]
	hair.texture = PlayerTextures.texture_atlas[weapon_type][state]["Hair"]["Black"][0]

func _set_stats():
	player_name.text = stats_resource.name
	ExpHandlers.calculate_total_level(stats_resource)
	stats_resource.current_health = stats_resource.max_health #will be removed during final setup
	if equipped_weapon:
		ExpHandlers.init_needed_xp_for_all_stats(stats_resource)
		stats_resource.max_health = stats_resource.max_health + equipped_weapon.HP_bonus #this will need to be set whenever player changes weapon
	

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
