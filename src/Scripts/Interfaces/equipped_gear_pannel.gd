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
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_equipped_weapon = Inventory.inventories["equipped_gear"]["weapon"]
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
