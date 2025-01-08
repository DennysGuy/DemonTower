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
@onready var eyes: Sprite2D = $PlayerParts/OnClimb/Eyes

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
var hair_styles : Array[String] = ["Black", "Brown", "Blond", "Red", "Green", "Blue"]
func _ready():
	update_sample_player = true
	
	hair_style_max_index = PlayerTextures.texture_atlas["Sword and Shield"]["Idle"]["Hair"]["Black"].keys().size()-1
	hair_color_max_index = PlayerTextures.texture_atlas["Sword and Shield"]["Idle"]["Hair"].keys().size()-1
	
	body_type_max_index = PlayerTextures.texture_atlas.keys().size()-1
	skin_color_max_index = PlayerTextures.texture_atlas["Sword and Shield"]["Idle"]["Head"].keys().size()-1
	
	eye_style_max_index = PlayerTextures.texture_atlas["Sword and Shield"]["Idle"]["Eyes"]["Green"].keys().size()-1
	eye_color_max_index = PlayerTextures.texture_atlas["Sword and Shield"]["Idle"]["Eyes"].keys().size()-1
	
	outfit_color_max_index = 2
	starter_weapon_max_index = starter_weapons.size()-1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#hairstyle
func _on_hs_move_back_pressed() -> void:
	hair_style_index -= 1
	if hair_style_index < 0:
		hair_style_index = hair_style_max_index
	update_sample_player = true


func _on_hs_move_forward_pressed() -> void:
	hair_style_index += 1
	if hair_style_index > hair_style_max_index:
		hair_style_index = 0
	update_sample_player = true

#haircolor
func _on_hc_move_back_pressed() -> void:
	hair_color_index -= 1
	if hair_color_index < 0:
		hair_color_index = hair_color_max_index
	update_sample_player = true


func _on_hc_move_forward_pressed() -> void:
	hair_style_index += 1
	if hair_style_index < hair_style_max_index:
		hair_style_index = hair_style_max_index
	update_sample_player = true

#eyes
func _on_es_move_back_pressed() -> void:
	pass # Replace with function body.


func _on_es_move_forward_pressed() -> void:
	pass # Replace with function body.

#eyecolor
func _on_ec_move_back_pressed() -> void:
	pass # Replace with function body.


func _on_ec_move_forward_pressed() -> void:
	pass # Replace with function body.

#bodytype
func _on_bt_move_back_pressed() -> void:
	pass # Replace with function body.


func _on_bt_move_forward_pressed() -> void:
	pass # Replace with function body.


#skincolor
func _on_sc_move_back_pressed() -> void:
	pass # Replace with function body.


func _on_sc_move_forward_pressed() -> void:
	pass # Replace with function body.

#outfitcolor
func _on_oc_move_back_pressed() -> void:
	pass # Replace with function body.


func _on_oc_move_forward_pressed() -> void:
	pass # Replace with function body.

#starterweapon
func _on_sw_move_back_pressed() -> void:
	pass # Replace with function body.


func _on_sw_move_forward_pressed() -> void:
	pass # Replace with function body.


func _on_start_game_pressed() -> void:
	pass # Replace with function body.


func _on_cancel_pressed() -> void:
	pass # Replace with function body.


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		sword.hide()
		shield.hide()
	else:
		sword.show()
		shield.show()
