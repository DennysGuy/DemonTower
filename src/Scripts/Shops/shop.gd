extends Control

@export_group("Shop Name")
@export var this_name : String
@export var shop_title : Label
@export_group("Shop Nodes")
@export_group("List Tabs")
@export var for_sale_button : Button
@export var buy_back_button : Button
@export_group("Shop Lists")
@export var items_for_sale : Array[Item]
var buy_back_list : Dictionary = {
	"buyback" : {	
	},
	"metadata": {
		"slot_quantity": 25,
		"key_ids": 0
	}
}
@export_group("Shop Item List")
@export var shop_list : GridContainer
@export_group("Player Inventory")
@export var player_inventory_list : GridContainer

@export_group("Confirmation Windows")
@export_group("Quantity Panel")
@export var quantity_panel : ColorRect
@export var quantity_input : TextEdit
@export var quantity_purchase_button : Button
@export var quantity_cancel_button : Button
@export_group("Confirmation Panel")
@export var confirmation_panel : ColorRect
@export var confirmation_button : Button
@export var confirmation_cancel : Button
@export_group("Insufficient Funds Panel")
@export var insufficient_funds_panel : ColorRect
@export var close_insufficient_funds_panel : Button
@export_group("Transaction Successful Panel")
@export var transaction_successful_panel : ColorRect
@export var close_transaction_successful_panel : Button
@export_group("Player Sale Panels")
@export var confirm_quantity_sale_panel : ColorRect
@export var quantity_sale_input : TextEdit
@export var confirm_sale_panel : ColorRect

@export_group("Gold")
@export var gold_label : Label
var _item_data : Item
var _inventory_tab : String = "weapons"
var _show_quantity : bool
var shop_name : String
var inventory_needs_update : bool = false
var display_items_for_sale : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quantity_panel.hide()
	confirmation_panel.hide()
	transaction_successful_panel.hide()
	insufficient_funds_panel.hide()
	confirm_quantity_sale_panel.hide()
	confirm_sale_panel.hide()
	shop_name = this_name + " " + "shop"
	shop_title.text = shop_name
	_inventory_tab = "weapons"
	_show_quantity = false
	display_items_for_sale = true
	inventory_needs_update = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inventory_needs_update:
		display_inventory(_inventory_tab, _show_quantity)
		if display_items_for_sale:
			_display_items_for_sale()
		else:
			_display_buy_back_items()
		inventory_needs_update = false
	
func _on_shop_action(item_data : Item) -> void:
	_item_data = item_data
	if item_data.is_stackable:
		quantity_panel.show()
		confirmation_panel.hide()
	else:
		quantity_panel.hide()
		confirmation_panel.show()
		
func _on_player_action(item_data : Item):
	_item_data = item_data
	if item_data.is_stackable:
		confirm_quantity_sale_panel.show()
		confirm_sale_panel.hide()
	else:
		confirm_quantity_sale_panel.hide()
		confirm_sale_panel.show()

func _confirm_purchase() -> void:
	var player_gold = Inventory.inventories["metadata"]["gold"]
	if (player_gold - _item_data.shop_value) < 0:
		print("Not enough gold!")
		confirmation_panel.hide()
		_item_data = null
		insufficient_funds_panel.show()
	else:
		Inventory.inventories["metadata"]["gold"] -= _item_data.shop_value
		Inventory.add_item(_item_data.get_item_inventory_name(), _item_data, 1)
		confirmation_panel.hide()
		_item_data = null
		inventory_needs_update = true
		transaction_successful_panel.show()
		
func _confirm_purchase_quantity() -> void:
	var quantity_amount = quantity_input.text
	var player_gold = Inventory.inventories["metadata"]["gold"]
	if quantity_amount.is_valid_int():
		var total_price = _item_data.shop_value * int(quantity_amount)
		if  (player_gold - total_price) < 0:
			print("Not enough gold!")
			quantity_panel.hide()
			_item_data = null
			insufficient_funds_panel.show()
		else:
			Inventory.inventories["metadata"]["gold"] -= (total_price)
			Inventory.add_item(_item_data.get_item_inventory_name(), _item_data, int(quantity_amount))
			quantity_panel.hide()
			_item_data = null
			inventory_needs_update = true
			transaction_successful_panel.show()
			
func _display_items_for_sale() -> void:
	clear_item_container()
	for item in items_for_sale:
		var sale_item : ShopItem = load("res://src/Scenes/Shops/ShopItem.tscn").instantiate()
		sale_item.item_data = item
		sale_item.belongs_to_player = false
		sale_item.connect("shop_action", _on_shop_action)
		shop_list.add_child(sale_item)

func _display_buy_back_items() -> void:
	clear_item_container()
	for key in buy_back_list["buyback"]:
		var buy_back_item : ShopItem = load("res://src/Scenes/Shops/ShopItem.tscn").instantiate()
		buy_back_item.item_data = buy_back_list["buyback"][key]["item"]
		buy_back_item.belongs_to_player = false
		buy_back_item.quantity_label.text = str(buy_back_list["buyback"][key]["quantity"])
		buy_back_item.connect("shop_action", _on_shop_action)
		shop_list.add_child(buy_back_item)
		
func display_inventory(name: String, show_quantity: bool) -> void:
	#tab_title.text = name
	# Clear existing slots
	print(name)
	gold_label.text = str("Gold: ",Inventory.inventories["metadata"]["gold"])
	clear_player_inventory()
	# Get the inventory category
	var inventory: Dictionary = Inventory.inventories["categories"][name]
	for key in inventory.keys():
		# Access the specific item data using the key
		var item_data: Dictionary = inventory[key]
		# Instantiate the slot scene
		var shop_item : ShopItem = load("res://src/Scenes/Shops/ShopItem.tscn").instantiate()
		if item_data["item"].is_stackable:
			shop_item.quantity_label.show()
		else:
			shop_item.quantity_lable.hide()
		shop_item.belongs_to_player = true
		# Set the item data and quantity for the slot
		shop_item.set_item_data(item_data["item"])  # Pass the `item` field
		var quantity : int = item_data["quantity"]
		shop_item.quantity_label.text = str(quantity)
		#shop_item.set_quantity_label(quantity)# Pass the `quantity` field
		#shop_item.show_quantity = show_quantity
		shop_item.connect("player_action", _on_player_action)
		# Add the slot to the container
		player_inventory_list.add_child(shop_item)

func clear_item_container() -> void:
	for child in shop_list.get_children():
		child.queue_free()

func clear_player_inventory() -> void:
	for child in player_inventory_list.get_children():
		child.queue_free()

func _on_quantity_purchase_button_button_down() -> void:
	_confirm_purchase_quantity()

func _on_quantity_cancel_button_button_down() -> void:
	_item_data = null
	if quantity_panel.visible:
		quantity_panel.hide()

func _on_confirmation_button_button_down() -> void:
	_confirm_purchase()

func _on_confirmation_cancel_button_button_down() -> void:
	_item_data = null
	if confirmation_panel.visible:
		confirmation_panel.hide()

func _on_close_insufficient_funds_panel_button_down() -> void:
	insufficient_funds_panel.hide()

func _on_close_sale_success_panel_button_down() -> void:
	transaction_successful_panel.hide()

func _on_leave_store_button_button_down() -> void:
	_item_data = null
	self.hide()

func _on_weapon_tab_button_down() -> void:
	_inventory_tab = "weapons"
	_show_quantity = false
	inventory_needs_update = true

func _on_recipes_tab_button_down() -> void:
	_inventory_tab = "recipes"
	_show_quantity = false
	inventory_needs_update = true

func _on_accessories_tab_button_down() -> void:
	_inventory_tab = "accessories"
	_show_quantity = false
	inventory_needs_update = true

func _on_drip_tab_button_down() -> void:
	_inventory_tab = "drip"
	_show_quantity = false
	inventory_needs_update = true

func _on_consumables_tab_button_down() -> void:
	_inventory_tab = "consumables"
	inventory_needs_update = true
	_show_quantity = true

func _on_materials_tab_button_down() -> void:
	_inventory_tab = "materials"
	inventory_needs_update = true
	_show_quantity = true

# Helper function to add items
func add_item_to_shop(item : Item, quantity: int = 1) -> void:
	var inventory = buy_back_list
	var item_key = search_item(inventory["buyback"], item.id)
	#var slot = inventory[item_key]
	if item.is_stackable and item_key != -1:
		# Stackable items (like consumables)
		inventory["buyback"][item_key]["quantity"] += quantity
	else:
		# Check if inventory is full
			# Add a new item
		var next_key = inventory["metadata"]["key_ids"]
		inventory["buyback"][next_key] = {
			"id": item.id,
			"name": item.name,
			"quantity": quantity,
			"item": item
		}
			# Increment key_id for this category
		inventory["metadata"]["key_ids"] += 1
	print(inventory)
		
func remove_item(category: String, item : Item, quantity : int = 1) -> Array:
	var inventory = buy_back_list
	var item_key = search_item(inventory, item.id)
	var slot = inventory[item_key]
	var item_to_remove : Item = inventory[item_key]["item"]
	if item_key != -1:
		if item_to_remove.is_stackable:
			slot["quantity"] = max(0, slot["quantity"]-quantity)
			if slot["quantity"] == 0:
				inventory.erase(item_key)
		else:
			inventory.erase(item_key)
		
		return [item_to_remove, quantity]
	else:
		print_debug("Item not found in inventory!")
		return []

func search_item(inventory: Dictionary, item_id: int) -> int:
	for key in inventory.keys():
		if inventory[key]["id"] == item_id:
			return key
	return -1

func confirm_quantity_sale() -> void:
	#multiply gold by the quantity typed in
	#add the total gold value to the player's inventory
	#remove the quantity from the player's inventory and add it to the shop's buy back
	var quantity = quantity_sale_input.text
	if quantity.is_valid_int and int(quantity) > 0: #need to check if in bounds 
		var item_removed = Inventory.remove_item(_item_data.get_item_inventory_name(), _item_data, int(quantity))
		#we need to ensure that the quantity being removed is the quantity being sold
		#if the player types in an amount larger than what's in inventory, they should only 
		#be given the quantity residing in inventory
		var total_value = _item_data.sell_value * item_removed[1]
		Inventory.inventories["metadata"]["gold"] += total_value
		self.add_item_to_shop(_item_data, item_removed[1])
		_item_data = null
		inventory_needs_update = true
		confirm_quantity_sale_panel.hide()
		transaction_successful_panel.show()
	else:
		print("not a valid amount")

func confirm_sale() -> void:
	#add gold (sell value) to player's gold
	#remove items from player's inventory
	#add those items to the buy back list
	var total_value = _item_data.sell_value
	Inventory.inventories["metadata"]["gold"] += total_value
	Inventory.remove_item(_item_data.get_item_inventory_name(), _item_data)
	self.add_item_to_shop(_item_data)
	_item_data = null
	confirm_sale_panel.hide()
	transaction_successful_panel.show()

func _on_quantity_sale_button_button_down() -> void:
	confirm_quantity_sale()

func _on_quantity_sale_cancel_button_button_down() -> void:
	confirm_quantity_sale_panel.hide()
	_item_data = null

func _on_confirmation_sale_button_button_down() -> void:
	confirm_sale()

func _on_confirmation_sale_cancel_button_button_down() -> void:
	confirm_sale_panel.hide()
	_item_data = null

func _on_for_sale_button_button_down() -> void:
	display_items_for_sale = true
	inventory_needs_update = true

func _on_buy_back_button_button_down() -> void:
	display_items_for_sale = false
	inventory_needs_update = true
