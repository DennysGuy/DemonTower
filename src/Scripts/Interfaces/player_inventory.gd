class_name PlayerInventory extends Control

@onready var weapons_tab_button : Button = $HBoxContainer/SideBar/MarginContainer/ButtonContainer/WeaponsTabButton
@onready var recipes_tab_button : Button = $HBoxContainer/SideBar/MarginContainer/ButtonContainer/RecipesTabButton
@onready var accessories_tab_button : Button = $HBoxContainer/SideBar/MarginContainer/ButtonContainer/AccessoriesTabButton
@onready var drip_tab_button : Button = $HBoxContainer/SideBar/MarginContainer/ButtonContainer/DripTabButton
@onready var consumables_tab_button : Button = $HBoxContainer/SideBar/MarginContainer/ButtonContainer/ConsumablesTabButton
@onready var materials_tab_button : Button = $HBoxContainer/SideBar/MarginContainer/ButtonContainer/MaterialsTabButton
@onready var slot_container : GridContainer = $HBoxContainer/ListArea/ScrollContainer/MarginContainer/GridContainer
@onready var currency_display : Label = $HBoxContainer/ListArea/CurrencyCounter
@onready var tab_title : Label = $HBoxContainer/ListArea/TabTitle

#Details Nodes
@onready var item_icon : TextureRect = $HBoxContainer/Details/VBoxContainer/Icon
@onready var item_name : Label = $HBoxContainer/Details/VBoxContainer/Name
@onready var item_level : Label = $HBoxContainer/Details/VBoxContainer/Level
@onready var item_description : RichTextLabel = $HBoxContainer/Details/VBoxContainer/Description
@onready var stats : RichTextLabel = $HBoxContainer/Details/VBoxContainer/Stats


var inventory_name : String
var is_stackable : bool

signal update_inventory
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var wooden_sword_shield_item : Item = load("res://src/Resources/Items/Weapons/01_Common/WoodenSwordShield.tres")
	Inventory.add_item("weapons", wooden_sword_shield_item,1)
	var wand_item : Item = load("res://src/Resources/Items/Weapons/01_Common/WoodenWand.tres")
	Inventory.add_item("weapons", wand_item,1)
	var knives_item : Item = load("res://src/Resources/Items/Weapons/01_Common/WoodenKnives.tres")
	Inventory.add_item("weapons", knives_item,1)
	var claw_item : Item = load("res://src/Resources/Items/Weapons/01_Common/ClothClaw.tres")
	Inventory.add_item("weapons", claw_item,1)
	
	#print_debug(Inventory.inventories["categories"]["weapons"])
	inventory_name = "weapons"
	is_stackable = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	display_inventory(inventory_name, is_stackable)
	currency_display.text = "Currency: " + str(Inventory.inventories["metadata"]["gold"])

func _on_weapons_tab_button_button_down():
	#display_inventory("weapons", false)
	inventory_name = "weapons"
	is_stackable = false


func _on_recipes_tab_button_button_down():
	#display_inventory("recipes", false)
	inventory_name = "recipes"
	is_stackable = false

func _on_accessories_tab_button_button_down():
	#display_inventory("accessories", false)
	inventory_name = "accessories"
	is_stackable = false


func _on_drip_tab_button_button_down():
	#display_inventory("drip", false)
	inventory_name = "drip"
	is_stackable = false


func _on_consumables_tab_button_button_down():
	#display_inventory("consumables", true)
	inventory_name = "consumables"
	is_stackable = true


func _on_materials_tab_button_button_down():
	#display_inventory("materials", true)
	inventory_name = "materials"
	is_stackable = true

func display_inventory(name: String, show_quantity: bool):
	tab_title.text = name
	# Clear existing slots
	clear_slot_container()
	# Get the inventory category
	var inventory: Dictionary = Inventory.inventories["categories"][name]

	for key in inventory.keys():
		# Access the specific item data using the key
		var item_data: Dictionary = inventory[key]

		# Instantiate the slot scene
		var slot : InventorySlot = load("res://src/Scenes/Interfaces/Slot.tscn").instantiate()

		# Set the item data and quantity for the slot
		slot.set_item_data(item_data["item"])  # Pass the `item` field
		var quantity : int = item_data["quantity"]
		slot.set_quantity_label(quantity)# Pass the `quantity` field
		slot.show_quantity = show_quantity
		slot.connect("slot_action", _on_slot_action)
		# Add the slot to the container
		slot_container.add_child(slot)

func clear_slot_container():
	for child in slot_container.get_children():
		child.queue_free()

func _on_slot_action(item_data : Item):
	print("Item action recevied!", item_data)
	item_icon.texture = item_data.icon
	item_name.text = item_data.name
	if item_data.type == item_data.TYPE.WEAPON:
		item_level.text = "Level: " + str(item_data.level)
	item_description.text = item_data.description
	