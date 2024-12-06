class_name EquipmentCraftingStation extends Control

@export var crafting_panel : Panel
@export var inventory_slots : GridContainer
@export var close_station_button : Button

@export_group("Craft Panel")
@export var output_item_icon : TextureRect
@export var crafting_progress_bar : ProgressBar
@export var remaining_amount_label : Label
@export var succeeded_label : Label
@export var failed_label : Label
@export var recipe_quantity_left_label : Label

@export_group("Details Panel")
@export var details_icon : TextureRect
@export var recipe_name_label : Label
@export var recipe_description : RichTextLabel

var _recipe : Recipe
var _succeeded = 0
var _failed = 0
var stored_recipe : Dictionary = {}
var start_crafting : bool
var update_inventory_panel : bool
var update_craft_panel : bool
var update_details_panel : bool
var player : Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("players")
	clear_craft_panel()
	clear_details_panel()
	update_inventory_panel = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if update_inventory_panel:
		populate_recipe_inventory()
		update_inventory_panel = false
	
	if update_details_panel:
		if _recipe == null:
			clear_details_panel()
		else:
			pass
		update_details_panel = false
	
	if start_crafting:
		update_crafting_panel_visuals()
		process_materials(_recipe)

func clear_craft_panel() -> void:
	output_item_icon.texture = load("res://Assets/RecipeUnknown.png")
	crafting_progress_bar.value = 0
	recipe_quantity_left_label.text = ""
	remaining_amount_label.text = "Left: N/A"
	succeeded_label.text = "Success: N/A"
	failed_label.text = "Failed: N/A"

func clear_details_panel() -> void:
	details_icon.texture = load("res://Assets/RecipeUnknown.png")
	recipe_name_label.text = "No Recipe Selected"
	recipe_description.text = ""


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
		update_details_panel_visuals()
	else:
		update_details_panel = true
		_recipe = null

func _on_start_crafting_button_button_down() -> void:
	if _recipe and calculate_quantity(_recipe) > 0:
		_succeeded = 0
		_failed = 0
		var recipe_inventory : Dictionary = Inventory.inventories["categories"]["recipes"]
		var key = Inventory.search_item(recipe_inventory, _recipe.id)
		var removed_recipe = Inventory.remove_item("recipes", _recipe,recipe_inventory[key]["quantity"])
		stored_recipe[0] = {"recipe": removed_recipe[0], "quantity": removed_recipe[1]}
		output_item_icon.texture = _recipe.output_item.icon
		crafting_progress_bar.value = 0
		crafting_progress_bar.max_value = _recipe.crafting_time_cost
		update_crafting_panel_visuals()
		update_inventory_panel = true
		start_crafting = true	
	else:
		print("No recipe selected or not enough resources!")

func update_crafting_panel_visuals() -> void:
	crafting_progress_bar.value = 0
	recipe_quantity_left_label.text = str(stored_recipe[0]["quantity"])
	remaining_amount_label.text = "Left: " + str(calculate_quantity(_recipe))
	succeeded_label.text = "Success: " + str(_succeeded)
	failed_label.text = "Failed: " + str(_failed)

func update_details_panel_visuals() -> void:
	if _recipe:
		details_icon.texture = _recipe.icon
		recipe_name_label.text = _recipe.name
		recipe_description.text = "Level " + str(_recipe.recipe_level) + "\n" + "Equipment Type: " + _recipe.output_item.get_item_category() + "\n" + "Description: " + "\n" + _recipe.output_item.description + "\n" + "Ingredients: " + "\n" + _recipe.get_recipe()
	
func fill_crafting_progress_bar() -> void:
	crafting_progress_bar.value += player.stats_resource.crafting_speed

func populate_recipe_inventory() -> void:
	clear_inventory()
	var recipes_inventory : Dictionary = Inventory.inventories["categories"]["recipes"]
	for key in recipes_inventory.keys():
		var item : Item = recipes_inventory[key]["item"]
		var new_slot : InventorySlot = load("res://src/Scenes/Interfaces/Slot.tscn").instantiate()
		new_slot.item_data = item
		new_slot.quantity = recipes_inventory[key]["quantity"]
		new_slot.quantity_label.text = str(new_slot.quantity)
		new_slot.connect("slot_action", select_recipe)
		inventory_slots.add_child(new_slot)

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
	player.stats_resource.set_crafting_current_xp(player.stats_resource.get_crafting_current_xp()+recipe.xp_provided)
	_succeeded += 1

func process_materials(recipe : Recipe) -> void:
	var remaining_player_gold : int = Inventory.inventories["metadata"]["gold"] - recipe.crafting_fee
	var remaining_quantity = calculate_quantity(recipe)
	
	if  stored_recipe[0]["quantity"] <= 0 or remaining_quantity <= 0 or remaining_player_gold < 0 : #checks if there is insufficient resources or gold left
		terminate_process()
		#display_results()
		return
		
	if crafting_progress_bar.value >= crafting_progress_bar.max_value:
		remove_materials_from_inventory(recipe)
		add_product_to_inventory(recipe)
		stored_recipe[0]["quantity"] -= 1
		#wood_quantity_label.text = str(stored_wood[0]["quantity"])
		update_crafting_panel_visuals()
	else:
		fill_crafting_progress_bar()

func clear_inventory():
	for child in inventory_slots.get_children():
		child.queue_free()

func select_recipe(recipe : Recipe):
	if player.stats_resource.crafting_level >= recipe.recipe_level:
		_recipe = recipe
	else:
		print("Need crafting level " + str(recipe.recipe_level))

func terminate_process() -> void:
	if stored_recipe[0]["quantity"] <= 0:
		stored_recipe.erase(0)
	start_crafting = false
	update_inventory_panel = true
	clear_craft_panel()

func _on_close_station_button_down() -> void:
	if !stored_recipe.is_empty(): #we will add back the stored wood when exiting station
		Inventory.add_item("recipes", stored_recipe[0]["recipe"], stored_recipe[0]["quantity"])
		_recipe = null
		update_inventory_panel = true
		stored_recipe.erase(0)
	self.hide()
