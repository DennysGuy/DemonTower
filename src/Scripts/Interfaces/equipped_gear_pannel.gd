class_name EquippedGearPanel extends Control

@export var equipped_weapon_icon : TextureRect
@export var equipped_hat_icon : TextureRect
@export var equipped_gloves_icon : TextureRect
@export var equipped_amulet_icon : TextureRect
@export var equipped_shirt_icon : TextureRect
@export var equipped_pants_icont : TextureRect

#unequip button
@onready
var unequip_weapon_button : Button = $Panel/VBoxContainer/HBoxContainer/UnequipWeapon

var _equipped_weapon : Weapon
var _equipped_hat : Accessory
var _equipped_gloves : Accessory
var _equipped_amulet : Accessory
var _equipped_shirt : Drip
var _equipped_pants : Drip
var _equipped_shoes : Drip
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_equipped_weapon = Inventory.inventories["equipped_gear"]["weapon"]
	_equipped_hat = Inventory.inventories["equipped_gear"]["hat"]
	_equipped_gloves = Inventory.inventories["equipped_gear"]["gloves"]
	_equipped_amulet = Inventory.inventories["equipped_gear"]["amulet"]
	_equipped_shirt = Inventory.inventories["equipped_gear"]["shirt"]
	_equipped_pants = Inventory.inventories["equipped_gear"]["pants"]
	
	if _equipped_weapon:
		unequip_weapon_button.show()
		equipped_weapon_icon.texture = _equipped_weapon.icon
	else:
		unequip_weapon_button.hide()
		equipped_weapon_icon.texture = load("res://Assets/NotAvailable.png")

	

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

func _on_unequip_gloves_button_button_down() -> void:
	if _equipped_gloves:
		Inventory.add_item("accessories", _equipped_gloves, 1)
		_equipped_gloves = null
		Inventory.inventories["equipped_gear"]["gloves"] = null

func _on_unequip_amulet_button_button_down() -> void:
	if _equipped_amulet:
		Inventory.add_item("accessores", _equipped_amulet, 1)
		_equipped_amulet = null
		Inventory.inventories["equipped_gear"]["amulet"] = null

func _on_unequip_shirt_button_button_down() -> void:
	if _equipped_shirt:
		Inventory.add_item("drip", _equipped_shirt, 1)
		_equipped_shirt = null
		Inventory.inventories["equipped_gear"]["shirt"] = null

func _on_unequip_pants_button_button_down() -> void:
	if _equipped_pants:
		Inventory.add_item("drip", _equipped_pants, 1)
		_equipped_weapon = null
		Inventory.inventories["equipped_gear"]["pants"] = null

func _on_unequip_shoes_button_button_down() -> void:
	if _equipped_shoes:
		Inventory.add_item("drip", _equipped_shoes, 1)
		_equipped_weapon = null
		Inventory.inventories["equipped_gear"]["shoes"] = null
