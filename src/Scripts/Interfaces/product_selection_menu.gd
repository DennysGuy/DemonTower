class_name ProductCraftingStation extends Control

@export var product_list : ProductList
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

var player : Player
var _recipe : Recipe
var update_details_panel : bool
var update_resource_list : bool
var start_crafting : bool
var _succeeded = 0
var _failed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_details_panel = true
	update_resource_list = true
	start_crafting = false
	process_panel.hide()
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
			clear_product_list()
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
		process_materials(_recipe)
		
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

func _on_start_crafting_button_button_down():
	if _recipe and calculate_quantity(_recipe) > 0:
		process_icon.texture = _recipe.icon
		progress_bar.value = 0
		progress_bar.max_value = _recipe.crafting_time_cost
		_succeeded = 0
		_failed = 0
		update_process_panel_visuals(_recipe)
		start_crafting = true
		process_panel.show()
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
		update_process_panel_visuals(recipe)
	else:
		fill_progress_bar()

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

func update_process_panel_visuals(recipe : Recipe) -> void:
	progress_bar.value = 0
	amount_remaining_count.text = "Left: " + str(calculate_quantity(recipe))
	amount_succeeded_count.text = "Success: " + str(_succeeded)
	amount_failed_count.text = "Failed: " + str(_failed)

func fill_progress_bar() -> void:
	match(_recipe.recipe_type):
		_recipe.RecipeType.RESOURCE:
			progress_bar.value += player.stats_resource.smelting_speed
		_recipe.RecipeType.DISH:
			progress_bar.value += player.stats_resource.cooking_speed

func clear_product_list() -> void:
	for child in products.get_children():
		child.queue_free()

func terminate_process() -> void:
	start_crafting = false
	update_resource_list = true
	clear_process_panel()
	process_panel.hide()

func _on_close_panel_button_button_down():
	self.hide()
