extends Control

@onready var name_entry_box: TextEdit = $Scroll/NameEntryBox

#labels
@onready var hair_style_label: Label = $Scroll/HairStyle/Style
@onready var hair_color_label: Label = $Scroll/HairColor/ColorLabel
@onready var body_type_label : Label = $Scroll/BodyType/Type
@onready var eyes_type: Label = $Scroll/EyesType/Type
@onready var eyes_color: Label = $Scroll/EyesColor/Color
@onready var skin_color: Label = $Scroll/SkinColor/Color
@onready var outfit_color: Label = $Scroll/Color
@onready var starter_weapon_type: Label = $Scroll/Type

#player parts
@onready var shield: Sprite2D = $PlayerParts/Shield

@onready var left_arm: Sprite2D = $PlayerParts/LeftUpperBody/LeftArm
@onready var left_shirt_sleeve: Sprite2D = $PlayerParts/LeftUpperBody/LeftShirtSleeve
@onready var left_glove: Sprite2D = $PlayerParts/LeftUpperBody/LeftGlove

@onready var cape: Sprite2D = $PlayerParts/UpperMiddleBody/Cape
@onready var torso: Sprite2D = $PlayerParts/UpperMiddleBody/Torso
@onready var shirt_torso: Sprite2D = $PlayerParts/UpperMiddleBody/ShirtTorso

@onready var legs: Sprite2D = $PlayerParts/LowerBody/Legs
@onready var pants: Sprite2D = $PlayerParts/LowerBody/Pants
@onready var bottoms: Sprite2D = $PlayerParts/LowerBody/Bottoms

@onready var sword: Sprite2D = $PlayerParts/RightUpperBody/Sword
@onready var right_arm: Sprite2D = $PlayerParts/RightUpperBody/RightArm
@onready var right_shirt_sleeve: Sprite2D = $PlayerParts/RightUpperBody/RightShirtSleeve
@onready var right_glove: Sprite2D = $PlayerParts/RightUpperBody/RightGlove

@onready var head: Sprite2D = $PlayerParts/UpperBody/Head
@onready var eyes: Sprite2D = $PlayerParts/UpperBody/Eyes
@onready var hair: Sprite2D = $PlayerParts/UpperBody/Hair

var update_sample_player : bool

var hair_style_index = 0
var hair_style_max_index = 0

var hair_color_index = 0
var hair_color_max_index = 0

var body_type_index = 0
var body_type_max_index = 0

var eye_style_index = 0
var eye_style_max_index = 0

var eye_color_index = 0
var eye_color_max_index = 0

var skin_color_index = 0
var skin_color_max_index = 0

var outfit_color_index = 0
var outfit_color_max_index = 0

var starter_weapon_index = 0
var starter_weapon_max_index = 0

var starter_weapons : Array[String] = ["Sword and Shield", "Wand", "Knives"]
var hair_style_names : Array[String] = ["Med", "Short", "Long"]
var hair_colors : Array[String] = ["Black", "Brown", "Blond"]
var skin_colors : Array[String] = ["Light", "Med", "Dark"]
var eye_colors : Array[String] = ["Green", "Brown", "Blue"]
var outfit_colors : Array[String] = ["Green", "Red", "Blue"]

var textures : Dictionary = PlayerTextures.texture_atlas

func _ready():
	update_sample_player = true
	
	hair_style_max_index = PlayerTextures.texture_atlas["Sword and Shield"]["Idle"]["Hair"]["Black"].keys().size()-1
	#hair_style_max_index = hair_style_names.size()-1
	hair_color_max_index = textures["Sword and Shield"]["Idle"]["Hair"].keys().size()-1
	#hair_color_max_index = hair_colors.size()-1

	#body_type_max_index = textures.keys().size()-1
	skin_color_max_index = textures["Sword and Shield"]["Idle"]["Head"].keys().size()-1
	#skin_color_max_index = skin_colors.size()-1
	
	eye_style_max_index = textures["Sword and Shield"]["Idle"]["Eyes"]["Green"].keys().size()-1
	#eye_style_max_index = 2
	eye_color_max_index = textures["Sword and Shield"]["Idle"]["Eyes"].keys().size()-1
	#eye_color_max_index = eye_colors.size()-1
	
	#outfit_color_max_index = outfit_colors.size()-1
	outfit_color_max_index = textures["Sword and Shield"]["Idle"]["Shirt"].keys().size()-1
	#starter_weapon_max_index = starter_weapons.size()-1
	starter_weapon_max_index = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update_sample_player:
		#set labels
		skin_color.text = skin_colors[skin_color_index]
		hair_style_label.text = hair_style_names[hair_style_index]
		hair_color_label.text = hair_colors[hair_color_index]
		eyes_type.text = "Type " + str(eye_style_index+1)
		eyes_color.text = eye_colors[eye_color_index]
		body_type_label.text = "Type " + str(body_type_index+1)
		skin_color.text = skin_colors[skin_color_index] 
		outfit_color.text = outfit_colors[outfit_color_index]
		starter_weapon_type.text = starter_weapons[starter_weapon_index]
		
		#we'll need to incorporate another dictionary index when we implement the female body type
		#nullify all weapon, we'll set this later
		sword.texture = null
		shield.texture = null
		#body
		left_arm.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Left Arm"][skin_color_index]
		torso.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Torso"][skin_color_index]
		right_arm.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Right Arm"][skin_color_index]
		legs.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Legs"][skin_color_index]
		
		#head
		hair.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Hair"][hair_colors[hair_color_index]][hair_style_index]
		head.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Head"][skin_color_index]
		eyes.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Eyes"][eye_colors[eye_color_index]][eye_style_index]
		#shirt
		left_shirt_sleeve.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Shirt"][outfit_color_index]["Left Sleeve"]
		shirt_torso.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Shirt"][outfit_color_index]["Torso Shirt"]
		right_shirt_sleeve.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Shirt"][outfit_color_index]["Right Sleeve"]
		
		#gloves
		left_glove.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Gloves"]["Left Glove"][0]
		right_glove.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Gloves"]["Right Glove"][0]
		
		#pants
		pants.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Pants"][outfit_color_index]
		#boots
		bottoms.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Shoes"][0]
		#backpack
		cape.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Cape"][0]
		
		if starter_weapon_index == 0:
			shield.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Shield"][0]
			sword.texture = textures[starter_weapons[starter_weapon_index]]["Idle"]["Sword"][0]
			
		update_sample_player = false

func cycle_trait(dir : int, index, max_index) -> int:
	index += dir
	
	if dir < 0:
		if index < 0:
			index = max_index
	else:
		if index > max_index:
			index = 0
			
	update_sample_player = true
	return index

#hairstyle
func _on_hs_move_back_pressed() -> void:
	hair_style_index = cycle_trait(-1, hair_style_index, hair_style_max_index)


func _on_hs_move_forward_pressed() -> void:
	hair_style_index = cycle_trait(1, hair_style_index, hair_style_max_index)

#haircolor
func _on_hc_move_back_pressed() -> void:
	hair_color_index = cycle_trait(-1, hair_color_index, hair_color_max_index)


func _on_hc_move_forward_pressed() -> void:
	hair_color_index = cycle_trait(1, hair_color_index, hair_color_max_index)

#eyes
func _on_es_move_back_pressed() -> void:
	eye_style_index = cycle_trait(-1, eye_style_index, eye_style_max_index)

func _on_es_move_forward_pressed() -> void:
	eye_style_index = cycle_trait(1, eye_style_index, eye_style_max_index)

func _on_ec_move_back_pressed() -> void:
	eye_color_index = cycle_trait(-1, eye_color_index, eye_color_max_index)

func _on_ec_move_forward_pressed() -> void:
	eye_color_index = cycle_trait(1, eye_color_index, eye_color_max_index)

func _on_bt_move_back_pressed() -> void:
	body_type_index = cycle_trait(-1, body_type_index, body_type_max_index)

func _on_bt_move_forward_pressed() -> void:
	body_type_index = cycle_trait(1, body_type_index, body_type_max_index)

func _on_sc_move_back_pressed() -> void:
	skin_color_index = cycle_trait(-1, skin_color_index, skin_color_max_index)

func _on_sc_move_forward_pressed() -> void:
	skin_color_index = cycle_trait(1, skin_color_index, skin_color_max_index)

func _on_oc_move_back_pressed() -> void:
	outfit_color_index = cycle_trait(-1, outfit_color_index, outfit_color_max_index)

func _on_oc_move_forward_pressed() -> void:
	outfit_color_index = cycle_trait(1, outfit_color_index, outfit_color_max_index)

func _on_sw_move_back_pressed() -> void:
	starter_weapon_index = cycle_trait(-1, starter_weapon_index, starter_weapon_max_index)

func _on_sw_move_forward_pressed() -> void:
	starter_weapon_index = cycle_trait(1, starter_weapon_index, starter_weapon_max_index)

func get_shirt_resource(index : int):
	match(index):
		0:
			return load("res://src/Resources/Items/Drip/Shirts/01_Common/NomadShirt.tres")
		_:
			return 0

func get_pants_resource(index : int):
	match(index):
		0:
			return load("res://src/Resources/Items/Drip/Pants/01_Common/NomadPants.tres")
		_:
			return 0

func get_weapon_resource(index : int):
	match(index):
		0:
			return load("res://src/Resources/Items/Weapons/Archetypes/Warrior/SwordShields/01_Common/WoodSwordShield.tres")
		_:
			return 0
	
func create_new_player() -> void:
	var player_data : Stats = Stats.new()
	player_data.name = name_entry_box.text
	player_data.skin_color_index = skin_color_index
	player_data.eye_color = eye_colors[eye_color_index]
	player_data.eye_style_index = eye_style_index
	player_data.hair_style_index = hair_style_index
	player_data.hair_color = hair_colors[hair_color_index]
	player_data.body_type = body_type_index + 1
	
	Inventory.equip_gear("weapon", get_weapon_resource(starter_weapon_index))
	Inventory.equip_gear("shirt", get_shirt_resource(outfit_color_index))
	Inventory.equip_gear("pants", get_pants_resource(outfit_color_index))
	Inventory.equip_gear("gloves", load("res://src/Resources/Items/Accessories/Gloves/01_Common/NomadGloves.tres"))
	Inventory.equip_gear("shoes", load("res://src/Resources/Items/Drip/Shoes/01_Common/NomadBoots.tres"))
	Inventory.equip_gear("cape", load("res://src/Resources/Items/Accessories/Capes/01_Common/NomadBackPack.tres"))
	
	SaveManager.save_player_data(player_data)	

func _on_start_game_pressed() -> void:
	create_new_player()
	get_tree().change_scene_to_file("res://src/Scenes/Rooms/TestLevel.tscn")
	
func _on_cancel_pressed() -> void:
	pass # Replace with function body.


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		sword.hide()
		shield.hide()
	else:
		sword.show()
		shield.show()
