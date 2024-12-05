class_name ProductCraftingStation extends Control

@export var product_list : ProductList
@export var is_cooking_station : bool
@export var products : GridContainer
@export var title_text : String
@export var menu_title : Label
@export var close_panel_button : Button
@export_group("Details Panel")
@export var details_panel : Panel
@export var start_crafting_button : Button
@export var recipe_icon : TextureRect
@export var recipe_name : Label
@export var ingredients : RichTextLabel
@export_group("Process Panel")
@export var process_panel : ColorRect
@export var process_icon : TextureRect
@export var progress_bar : ProgressBar
@export var amount_remaining_count : Label
@export var amount_succeeded_count : Label
@export var amount_failed_count : Label
@export var terminate_process_button : Button
@export_group("Materials Inventory Panel")
@export var wood_selector_margin_container : MarginContainer
@export var wood_panel : Panel 
@export var materials_inventory_panel : Panel
@export var selected_wood_icon : TextureRect
@export var wood_quantity_label : Label
@export var wood_slots : GridContainer
@export_group("Cooking Process Panel")
@export var cooking_process_panel : ColorRect
@export var dish_process_icon : TextureRect
@export var dish_progress_bar : ProgressBar
@export var dish_remaining_label : Label
@export var dish_succeeded_label : Label
@export var dish_failed_label : Label
@export var dish_process_terminate_button : Button

var player : Player
var _recipe : Recipe
var _selected_wood : Wood
var update_details_panel : bool
var update_resource_list : bool
var start_crafting : bool
var _succeeded = 0
var _failed = 0
var stored_wood : Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	update_details_panel = true
	update_resource_list = true
	start_crafting = false
	process_panel.hide()
	cooking_process_panel.hide()
	materials_inventory_panel.hide()
	if is_cooking_station:
		wood_selector_margin_container.show()
	else:
		wood_selector_margin_container.hide()

	menu_title.text = title_text
	player = get_tree().get_first_node_in_group("players")
	#clear_product_list()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update_details_panel:
		if _recipe == null:
			clear_details()
		update_details_panel = false
	
	if update_resource_list:
		if player:
			clear_list(products)
			if product_list:
				for recipe in product_list.product_list:
					var new_product : Product = load("res://src/Scenes/Interfaces/Product.tscn").instantiate()
					#need to check if it's a resource or a dish
					var compared_level = 0
					new_product.recipe = recipe
					if new_product.recipe:
						match(new_product.recipe.recipe_type):
							new_product.recipe.RecipeType.RESOURCE:
								compared_level = player.stats_resource.smelting_level
							new_product.recipe.RecipeType.DISH:
								compared_level = player.stats_resource.cooking_level
						if compared_level >= new_product.recipe.recipe_level:
							new_product.quantity.text = "Can Make: " + str(calculate_quantity(new_product.recipe))
							new_product.recipe.player_can_craft = true
							new_product.set_visibility(true)
						else:
							new_product.recipe.player_can_craft = false
							new_product.set_visibility(false)
						new_product.connect("select_recipe", _select_recipe)
						products.add_child(new_product)
					else:
						print("recipe not found")
		update_resource_list = false
	
	if start_crafting:
		process_panel.show()
		if !is_cooking_station:
			process_materials(_recipe)
		else:
			cook_dish(_recipe)
		
func calculate_quantity(recipe: Recipe) -> int:
	#get recipe material's list
	#iterate through the list and divide the quantity required by how many is in 
	#player's inventory
	#we will return the lowest of the bunch as the number the player can make will be contingent on the lowest resource
	var material_inventory : Dictionary = Inventory.inventories["categories"]["materials"]
	var viable_amount = 99999999999
	
	for craft_material in recipe.materials_list:
		var key : int = Inventory.search_item(material_inventory, craft_material.id)
		if key != -1:
			var inventory_amt : int = material_inventory[key]["quantity"]
			var divisor : int = (inventory_amt/recipe.materials_list[craft_material])
			if divisor < viable_amount:
				viable_amount = divisor
		else:
			return 0 #will end the function here as the player doesn't have the necessary item
			
	return viable_amount

func _select_recipe(recipe : Recipe) -> void:
	if recipe.player_can_craft:
		_recipe = recipe
		recipe_icon.texture = _recipe.icon
		recipe_name.text = _recipe.name
		ingredients.text = _recipe.get_recipe()
	else:
		update_details_panel = true
		_recipe = null

func clear_details() -> void:
	recipe_icon.texture = load("res://Assets/RecipeUnknown.png")
	recipe_name.text = "N/A"
	ingredients.text = "No Recipe Selected"

func clear_process_panel() -> void:
	process_icon.texture = load("res://Assets/RecipeUnknown.png")
	progress_bar.value = 0
	amount_remaining_count.text = "Left: N/A"
	amount_succeeded_count.text = "Success: N/A"
	amount_failed_count.text = "Failed: N/A"

func clear_cooking_process_panel() -> void:
	dish_process_icon.texture = load("res://Assets/RecipeUnknown.png")
	dish_progress_bar.value = 0
	dish_remaining_label.text = "Left: N/A"
	dish_succeeded_label.text = "Success: N/A"
	dish_failed_label.text = "Failed: N/A"

func _on_start_crafting_button_button_down():
	if _recipe and calculate_quantity(_recipe) > 0:
		_succeeded = 0
		_failed = 0
		
		if !is_cooking_station:
			process_icon.texture = _recipe.icon
			progress_bar.value = 0
			progress_bar.max_value = _recipe.crafting_time_cost
			update_process_panel_visuals(_recipe, progress_bar, amount_remaining_count, amount_succeeded_count, amount_failed_count)
			process_panel.show()
		else:
			dish_process_icon.texture = _recipe.icon
			dish_progress_bar.value = 0
			progress_bar.max_value = _recipe.crafting_time_cost
			update_process_panel_visuals(_recipe, dish_progress_bar, dish_remaining_label, dish_succeeded_label, dish_failed_label)
			cooking_process_panel.show()
		
		start_crafting = true	
	else:
		print("No recipe selected or not enough resources!")

func _on_terminate_process_button_button_down():
	terminate_process()

func process_materials(recipe : Recipe) -> void:
	#We'll watch a progress bar fill up.
	#When the progress bar is full, we'll run the appropriate commands
	#There needs to be some math done to calculate the speed of the progress bar
	#This will be based on the player's refining level and the recipe level
	#When the progress bar is full, we'll make the necessary changes
	#We'll check the amount the player is able to make, if it's greater than zero, we'll continue
	#if not, we'll break the loop
	var remaining_player_gold : int = Inventory.inventories["metadata"]["gold"] - recipe.crafting_fee
	if calculate_quantity(recipe) <= 0 or remaining_player_gold < 0: #checks if there is insufficient resources or gold left
		terminate_process()
		return
		
	if progress_bar.value >= progress_bar.max_value:
		remove_materials_from_inventory(recipe)
		add_product_to_inventory(recipe)
		update_process_panel_visuals(recipe, progress_bar, amount_remaining_count, amount_succeeded_count, amount_failed_count)
	else:
		fill_progress_bar(progress_bar)

func cook_dish(recipe : Recipe) -> void:
	var remaining_player_gold : int = Inventory.inventories["metadata"]["gold"] - recipe.crafting_fee
	if calculate_quantity(recipe) <= 0 or remaining_player_gold < 0 or stored_wood[0]["quantity"] <= 0: #checks if there is insufficient resources or gold left
		terminate_process()
		return
		
	if progress_bar.value >= progress_bar.max_value:
		remove_materials_from_inventory(recipe)
		add_product_to_inventory(recipe)
		stored_wood[0]["quantity"] -= 1
		wood_quantity_label.text = stored_wood[0]["quantity"]
		update_process_panel_visuals(recipe, dish_progress_bar, dish_remaining_label, dish_succeeded_label, dish_failed_label)
	else:
		fill_progress_bar(dish_progress_bar)

func remove_materials_from_inventory(recipe : Recipe) -> void:
	var material_inventory : Dictionary = Inventory.inventories["categories"]["materials"]
	for craft_material in recipe.materials_list:
		var quantity_needed : int = recipe.materials_list[craft_material]
		var key : int = Inventory.search_item(material_inventory, craft_material.id)
		if key != -1: # if the item was found in inventory, proceed
			var amount_in_inventory : int = material_inventory[key]["quantity"] #get the quantity stored in inventory
			if quantity_needed <= amount_in_inventory: #if the quantity needed to make the item is less than what's currently in inventory, we'll remove the amount from inventory
				var removed_item = Inventory.remove_item(craft_material.get_item_inventory_name(), craft_material, quantity_needed)
				#we'll need to do some calculations here to determine if failed or succeeded
			else:
				start_crafting = false
				return # we need to break the loop as we cannot make any more
		else:
			start_crafting = false # if the material isn't in inventory we'll end the process.
			return

func add_product_to_inventory(recipe : Recipe):
	Inventory.add_item(recipe.output_item.get_item_inventory_name(), recipe.output_item)
	#remove gold -- this will be applied if failed too, but at a small cost
	Inventory.inventories["metadata"]["gold"] -= recipe.crafting_fee
	print(Inventory.inventories["metadata"]["gold"])
	#apply xp
	match(recipe.recipe_type):
		recipe.RecipeType.RESOURCE:
			player.stats_resource.set_smelting_current_xp(player.stats_resource.get_smelting_current_xp()+recipe.xp_provided)
		recipe.RecipeType.DISH:
			#may also need to apply fire making xp here?
			player.stats_resource.set_cooking_current_xp(player.stats_resource.get_cooking_current_xp()+recipe.xp_provided)
	
	_succeeded += 1

func update_process_panel_visuals(recipe : Recipe, _progress_bar : ProgressBar, _amount_remaining_count : Label, _amount_succeeded_count : Label, _amount_failed_count : Label) -> void:
	_progress_bar.value = 0
	_amount_remaining_count.text = "Left: " + str(calculate_quantity(recipe))
	_amount_succeeded_count.text = "Success: " + str(_succeeded)
	_amount_failed_count.text = "Failed: " + str(_failed)

func fill_progress_bar(_progress_bar : ProgressBar) -> void:
	match(_recipe.recipe_type):
		_recipe.RecipeType.RESOURCE:
			_progress_bar.value += player.stats_resource.smelting_speed
		_recipe.RecipeType.DISH:
			_progress_bar.value += player.stats_resource.cooking_speed

func clear_list(container : GridContainer) -> void:
	for child in container.get_children():
		child.queue_free()

func set_recipe_list(selected_wood : Wood) -> void:
	if player.stats_resource.fire_making_level >= selected_wood.level:
		var materials_inventory = Inventory.inventories["categories"]["materials"]
		product_list = selected_wood.product_list
		var key = Inventory.search_item(materials_inventory, selected_wood.id)
		var removed_wood = Inventory.remove_item("materials", materials_inventory[key]["item"], materials_inventory[key]["quantity"])
		stored_wood[0] = {"wood" : removed_wood[0], "quantity": removed_wood[1]}
		selected_wood_icon.texture = stored_wood[0]["wood"].icon
		wood_quantity_label.text = str(stored_wood[0]["quantity"])
		materials_inventory_panel.hide()
		update_resource_list = true
		
	else:
		print("Need level " + str(selected_wood.level) + " Fire Making")

func create_wood_inventory() -> void:
	clear_list(wood_slots)
	var materials_inventory : Dictionary = Inventory.inventories["categories"]["materials"]
	for key in materials_inventory.keys():
		var item : Item = materials_inventory[key]["item"]
		if item.get_item_category() == "wood":
			var new_slot : InventorySlot = load("res://src/Scenes/Interfaces/Slot.tscn").instantiate()
			new_slot.item_data = item
			new_slot.quantity = materials_inventory[key]["quantity"]
			new_slot.quantity_label.text = str(new_slot.quantity)
			new_slot.connect("slot_action", set_recipe_list)
			wood_slots.add_child(new_slot)

func terminate_process() -> void:
	start_crafting = false
	update_resource_list = true
	if !is_cooking_station:
		clear_process_panel()
		process_panel.hide()
	else:
		clear_cooking_process_panel()
		selected_wood_icon.texture = null
		wood_quantity_label.text = ""
		cooking_process_panel.hide()

func _on_close_panel_button_button_down():
	if is_cooking_station:
		if !stored_wood.is_empty(): #we will add back the stored wood when exiting station
			Inventory.add_item("materials", stored_wood[0]["wood"], stored_wood[0]["quantity"])
			selected_wood_icon.texture = null
			wood_quantity_label.text = ""
			stored_wood.erase(0)
	self.hide()

func _on_wood_selector_gui_input(event : InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#print_debug("I'm clicked!!")
		create_wood_inventory()
		materials_inventory_panel.show()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if !stored_wood.is_empty():
			selected_wood_icon.texture = null
			wood_quantity_label.text = ""
			Inventory.add_item("materials", stored_wood[0]["wood"], stored_wood[0]["quantity"])
			
func _on_close_inventory_panel_button_down():
	materials_inventory_panel.hide()
