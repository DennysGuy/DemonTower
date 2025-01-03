class_name EquippedGearPanel extends Control

@export var equipped_weapon_icon : TextureRect
@export var equipped_hat_icon : TextureRect
@export var equipped_gloves_icon : TextureRect
@export var equipped_amulet_icon : TextureRect
@export var equipped_shirt_icon : TextureRect
@export var equipped_pants_icon : TextureRect
@export var equipped_shoes_icon : TextureRect

#unequip button
@onready
var unequip_weapon_button : Button = $Panel/VBoxContainer/HBoxContainer/UnequipWeapon
@onready
var unequip_hat_button : Button = $Panel/VBoxContainer/HBoxContainer2/UnequipHatButton
@onready
var unequip_gloves_button : Button = $Panel/VBoxContainer/HBoxContainer3/UnequipGlovesButton
@onready
var unequip_amulet_button : Button = $Panel/VBoxContainer/HBoxContainer4/UnequipAmuletButton
@onready
var unequip_shirt_button : Button = $Panel/VBoxContainer/HBoxContainer5/UnequipShirtButton
@onready
var unequip_pants_button : Button = $Panel/VBoxContainer/HBoxContainer6/UnequipPantsButton
@onready
var unequip_shoes_button : Button = $Panel/VBoxContainer/HBoxContainer7/UnequipShoesButton

@export
var not_available_icon : Texture2D

var _equipped_weapon : Weapon
var _equipped_hat : Accessory
var _equipped_gloves : Accessory
var _equipped_amulet : Accessory
var _equipped_shirt : Drip
var _equipped_pants : Drip
var _equipped_shoes : Drip

var player : Player
# Called when the node enters the scene tree for the first time.
func _ready():
	var players = get_tree().get_nodes_in_group("players")
	if players.size() > 0:
		player = players[0]
		print("Player found:",player)
	_equipped_weapon = Inventory.inventories["equipped_gear"]["weapon"]
	_equipped_hat = Inventory.inventories["equipped_gear"]["hat"]
	_equipped_gloves = Inventory.inventories["equipped_gear"]["gloves"]
	_equipped_amulet = Inventory.inventories["equipped_gear"]["amulet"]
	_equipped_shirt = Inventory.inventories["equipped_gear"]["shirt"]
	_equipped_pants = Inventory.inventories["equipped_gear"]["pants"]
	_equipped_shoes = Inventory.inventories["equipped_gear"]["shoes"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_equipped_weapon = Inventory.inventories["equipped_gear"]["weapon"]
	_equipped_hat = Inventory.inventories["equipped_gear"]["hat"]
	_equipped_gloves = Inventory.inventories["equipped_gear"]["gloves"]
	_equipped_amulet = Inventory.inventories["equipped_gear"]["amulet"]
	_equipped_shirt = Inventory.inventories["equipped_gear"]["shirt"]
	_equipped_pants = Inventory.inventories["equipped_gear"]["pants"]
	_equipped_shoes = Inventory.inventories["equipped_gear"]["shoes"]
	
	if _equipped_weapon:
		unequip_weapon_button.show()
		equipped_weapon_icon.texture = _equipped_weapon.icon
	else:
		unequip_weapon_button.hide()
		equipped_weapon_icon.texture = not_available_icon

	if _equipped_hat:
		unequip_hat_button.show()
		equipped_hat_icon.texture = _equipped_hat.icon
	else:
		unequip_hat_button.hide()
		equipped_hat_icon.texture = not_available_icon
	
	if _equipped_gloves:
		unequip_gloves_button.show()
		equipped_gloves_icon.texture = _equipped_gloves.icon
	else:
		unequip_gloves_button.hide()
		equipped_gloves_icon.texture = not_available_icon
	
	if _equipped_amulet:
		unequip_amulet_button.show()
		equipped_amulet_icon.texture = _equipped_amulet.icon
	else:
		unequip_amulet_button.hide()
		equipped_amulet_icon.texture = not_available_icon	
	
	if _equipped_shirt:
		unequip_shirt_button.show()
		equipped_shirt_icon.texture = _equipped_shirt.icon
	else:
		unequip_shirt_button.hide()
		equipped_shirt_icon.texture = not_available_icon
	
	if _equipped_pants:
		unequip_pants_button.show()
		equipped_pants_icon.texture = _equipped_pants.icon
	else:
		unequip_pants_button.hide()
		equipped_pants_icon.texture = not_available_icon
	
	if _equipped_shoes:
		unequip_shoes_button.show()
		equipped_shoes_icon.texture = _equipped_shoes.icon
	else:
		unequip_shoes_button.hide()
		equipped_shoes_icon.texture = not_available_icon

func _on_unequip_weapon_button_down() -> void:
	if _equipped_weapon:
		Inventory.add_item("weapons", _equipped_weapon, 1)
		_equipped_weapon = null
		Inventory.inventories["equipped_gear"]["weapon"] = null

func _on_unequip_hat_button_button_down() -> void:
	if _equipped_hat:
		Inventory.add_item("accessories", _equipped_hat, 1)
		_equipped_hat = null
		Inventory.inventories["equipped_gear"]["hat"] = null
	player.set_textures("Idle")
		
func _on_unequip_gloves_button_button_down() -> void:
	if _equipped_gloves:
		Inventory.add_item("accessories", _equipped_gloves, 1)
		_equipped_gloves = null
		Inventory.inventories["equipped_gear"]["gloves"] = null
	player.left_glove.texture = null
	player.right_glove.texture = null
	player.set_textures("Idle")
	
func _on_unequip_amulet_button_button_down() -> void:
	if _equipped_amulet:
		Inventory.add_item("accessories", _equipped_amulet, 1)
		_equipped_amulet = null
		Inventory.inventories["equipped_gear"]["amulet"] = null
	player.set_textures("Idle")
	
func _on_unequip_shirt_button_button_down() -> void:
	if _equipped_shirt:
		Inventory.add_item("drip", _equipped_shirt, 1)
		_equipped_shirt = null
		Inventory.inventories["equipped_gear"]["shirt"] = null
	
	player.left_shirt_sleeve.texture = null
	player.shirt_torso.texture = null
	player.right_shirt_sleeve.texture = null
	player.set_textures("Idle")
	
func _on_unequip_pants_button_button_down() -> void:
	if _equipped_pants:
		Inventory.add_item("drip", _equipped_pants, 1)
		_equipped_weapon = null
		Inventory.inventories["equipped_gear"]["pants"] = null
	player.pants.texture = null
	player.set_textures("Idle")
	
func _on_unequip_shoes_button_button_down() -> void:
	if _equipped_shoes:
		Inventory.add_item("drip", _equipped_shoes, 1)
		_equipped_weapon = null
		Inventory.inventories["equipped_gear"]["shoes"] = null
	player.bottoms.texture = null
	player.set_textures("Idle")
