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
@export var buy_back_list : Dictionary
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
@export_group("Gold")
@export var gold_label : Label
var _item_data : Item
var _inventory_tab : String = "weapons"
var _show_quantity : bool
var shop_name : String
var inventory_needs_update : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	quantity_panel.hide()
	confirmation_panel.hide()
	transaction_successful_panel.hide()
	insufficient_funds_panel.hide()
	shop_name = this_name + " " + "shop"
	shop_title.text = shop_name
	display_inventory("weapons", false)
	_display_items_for_sale()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inventory_needs_update:
		display_inventory(_inventory_tab, false)
		inventory_needs_update = false
	
func _on_shop_action(item_data : Item):
	_item_data = item_data
	if item_data.is_stackable:
		quantity_panel.show()
		confirmation_panel.hide()
	else:
		quantity_panel.hide()
		confirmation_panel.show()

func _confirm_player_item_sale():
	pass

func _confirm_purchase():
	var player_gold = Inventory.inventories["meta_data"]["gold"]
	if (player_gold - _item_data.shop_value) < 0:
		print("Not enough gold!")
		quantity_panel.hide()
		_item_data = null
		insufficient_funds_panel.show()
	else:
		Inventory.inventories["meta_data"]["gold"] -= _item_data.shop_value
		Inventory.add_item(_item_data.get_item_inventory_name(), _item_data, 1)
		quantity_panel.hide()
		_item_data = null
		inventory_needs_update = true
		transaction_successful_panel.show()
		
func _confirm_purchase_quantity():
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
			
func _display_items_for_sale():
	clear_item_container()
	for item in items_for_sale:
		var sale_item : ShopItem = load("res://src/Scenes/Shops/ShopItem.tscn").instantiate()
		sale_item.item_data = item
		sale_item.belongs_to_player = false
		sale_item.connect("shop_action", _on_shop_action)
		shop_list.add_child(sale_item)

func _display_buy_back_items():
	clear_item_container()
	
func display_inventory(name: String, show_quantity: bool):
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
		shop_item.belongs_to_player = true
		# Set the item data and quantity for the slot
		shop_item.set_item_data(item_data["item"])  # Pass the `item` field
		var quantity : int = item_data["quantity"]
		#shop_item.set_quantity_label(quantity)# Pass the `quantity` field
		#shop_item.show_quantity = show_quantity
		#shop_item.connect("player_action", _on_player_action)
		# Add the slot to the container
		player_inventory_list.add_child(shop_item)

func clear_item_container():
	for child in shop_list.get_children():
		child.queue_free()

func clear_player_inventory():
	for child in player_inventory_list.get_children():
		child.queue_free()

func _on_quantity_purchase_button_button_down():
	_confirm_purchase_quantity()

func _on_quantity_cancel_button_button_down():
	_item_data = null
	if quantity_panel.visible:
		quantity_panel.hide()

func _on_confirmation_button_button_down():
	_confirm_purchase()

func _on_confirmation_cancel_button_button_down():
	_item_data = null
	if confirmation_panel.visible:
		confirmation_panel.hide()

func _on_close_insufficient_funds_panel_button_down():
	insufficient_funds_panel.hide()

func _on_close_sale_success_panel_button_down():
	transaction_successful_panel.hide()

func _on_leave_store_button_button_down():
	_item_data = null
	self.hide()

func _on_weapon_tab_button_down():
	_inventory_tab = "weapons"
	_show_quantity = false
	inventory_needs_update = true

func _on_recipes_tab_button_down():
	_inventory_tab = "recipes"
	_show_quantity = false
	inventory_needs_update = true

func _on_accessories_tab_button_down():
	_inventory_tab = "accessories"
	_show_quantity = false
	inventory_needs_update = true

func _on_drip_tab_button_down():
	_inventory_tab = "drip"
	_show_quantity = false
	inventory_needs_update = true

func _on_consumables_tab_button_down():
	_inventory_tab = "consumables"
	inventory_needs_update = true
	_show_quantity = true

func _on_materials_tab_button_down():
	_inventory_tab = "materials"
	inventory_needs_update = true
	_show_quantity = true
