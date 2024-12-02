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
@onready var equip_button : Button = $HBoxContainer/Details/EquipButton
@onready var consume_button : Button = $HBoxContainer/Details/ConsumeButton
@onready var item_name : Label = $HBoxContainer/Details/VBoxContainer/Name
@onready var item_level : Label = $HBoxContainer/Details/VBoxContainer/Level
@onready var item_description : RichTextLabel = $HBoxContainer/Details/VBoxContainer/Description
@onready var stats : RichTextLabel = $HBoxContainer/Details/VBoxContainer/Stats
@onready var discard_button : Button = $HBoxContainer/Details/DiscardButton
@onready var drop_amount_panel : Panel = $DropAmountPanel
@onready var drop_amount_input : TextEdit = $DropAmountPanel/InputAmountBox
@onready var confirm_drop_amount_button : Button = $DropAmountPanel/ConfirmDropButton

var inventory_name : String
var is_stackable : bool
var _item_data : Item
var _item_drop
var player : Player
signal update_inventory
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var players = get_tree().get_nodes_in_group("players")
	if players.size() > 0:
		player = players[0]
		print("Player found:",player)
	clear_details()
	drop_amount_panel.hide()
	consume_button.hide()
	equip_button.hide()

	inventory_name = "weapons"
	is_stackable = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	display_inventory(inventory_name, is_stackable)
	currency_display.text = "Currency: " + str(Inventory.inventories["metadata"]["gold"])
	if _item_data:
		discard_button.show()
	else:
		discard_button.hide()

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

func _on_slot_action(item_data : Item) -> void:
	_item_data = item_data
	item_icon.texture = item_data.icon
	item_name.text = item_data.name
	item_description.text = item_data.description
	
	if not(item_data.type == item_data.TYPE.CONSUMABLE\
	or item_data.type == item_data.TYPE.RECIPE\
	or item_data.type == item_data.TYPE.MATERIAL):
		consume_button.hide()
		equip_button.show()
	if item_data.type == item_data.TYPE.CONSUMABLE:
		equip_button.hide()
		consume_button.show()
	if item_data.type == item_data.TYPE.WEAPON:
		item_level.text = "Level: " + str(item_data.level) + " Archetype: " + str(item_data.get_archetype_class_name())
	
func _on_equip_button_button_down():
	#need to transfer item data from slot to equip
	#first take item data from inventory
	#store
	var equipped_gear_slot
	if _item_data.type == _item_data.TYPE.ACCESSORY:
		equipped_gear_slot = Inventory.inventories["equipped_gear"][_item_data.get_accessory_type()]
		Inventory.equip_gear(_item_data.get_accessory_type(), _item_data)
	elif _item_data.type == _item_data.TYPE.DRIP:
		equipped_gear_slot =  Inventory.inventories["equipped_gear"][_item_data.get_drip_type_name()]
		Inventory.equip_gear(_item_data.get_drip_type_name(), _item_data)
	else:
		equipped_gear_slot = Inventory.inventories["equipped_gear"][_item_data.get_item_category()]
		Inventory.equip_gear(_item_data.get_item_category(), _item_data)
	
	if equipped_gear_slot:
		Inventory.add_item(_item_data.get_item_inventory_name(), equipped_gear_slot, 1)
	Inventory.remove_item(_item_data.get_item_inventory_name(), _item_data)
	
	clear_details()
	_item_data = null

func _on_discard_button_button_down() -> void:
	var item_inventory = Inventory.inventories["categories"][_item_data.get_item_inventory_name()]
	var key = Inventory.search_item(item_inventory, _item_data.id)
	var item_slot = item_inventory[key]
	
	if _item_data.is_stackable and item_slot["quantity"] > 1:
		drop_amount_panel.show()
	else:
		clear_details()
		_item_drop = Inventory.remove_item(_item_data.get_item_inventory_name(), _item_data)
		var item_interactable : ItemInteractable = load("res://src/Scenes/Items/ItemInteractable.tscn").instantiate()
		item_interactable.item_data = _item_drop[0]
		item_interactable.global_position = player.global_position + Vector2(0,-5)
		if item_interactable.item_data != null:
			get_tree().current_scene.add_child(item_interactable)
		_item_drop = null
		_item_data = null
	
func clear_details() -> void:
	drop_amount_panel.hide()
	consume_button.hide()
	equip_button.hide()
	item_icon.texture = null
	item_level.text = "N/A"
	item_name.text = "N/A"
	item_description.text = "N/A"

func _on_consume_button_button_down() -> void:
	if _item_data.type == _item_data.TYPE.CONSUMABLE:
		if _item_data.consumable_type == _item_data.ConsumableType.REPLENISHING:
			Inventory.remove_item(_item_data.get_item_inventory_name(), _item_data)
			player.health_component.apply_healing(_item_data.provided_hp)
			player.health_component.apply_mp_replenish(_item_data.provided_mp)

func _on_confirm_drop_button_button_down() -> void:
	var drop_amount = drop_amount_input.text
	if drop_amount.is_valid_int():	
		_item_drop = Inventory.remove_item(_item_data.get_item_inventory_name(), _item_data, int(drop_amount))
		var item_interactable : ItemInteractable = load("res://src/Scenes/Items/ItemInteractable.tscn").instantiate()
		item_interactable.item_data = _item_drop[0]
		item_interactable.quantity = _item_drop[1]
		item_interactable.global_position = player.global_position + Vector2(0,-5)
		if item_interactable.item_data != null:
			get_tree().current_scene.add_child(item_interactable)
			print("You have drop " + drop_amount + " " + _item_data.name)
		_item_drop = null
		drop_amount_panel.hide()
		
