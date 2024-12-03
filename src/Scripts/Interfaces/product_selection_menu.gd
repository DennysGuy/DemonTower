class_name ProductSelectionList extends Control

@export var product_list : ProductList
@export var products : GridContainer
var player : Player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("Players")
	for recipe in product_list.product_list:
		var new_product : Product = load("res://src/Scenes/Interfaces/Product.tscn").instantiate()
		#need to check if it's a resource or a dish
		var compared_level = 0
		new_product.set_recipe(recipe)
		if new_product.recipe:
			match(new_product.recipe.recipe_type):
				new_product.recipe.RecipeType.RESOURCE:
					compared_level = player.stats_resource.smelting_level
				new_product.recipe.RecipeType.DISH:
					compared_level = player.stats_resource.cooking_level
			if compared_level >= new_product.recipe.recipe_level:
				new_product.quantity.text = "Can Make: " + str(calculate_quantity(new_product.recipe))
				new_product.set_visibility(true)
			else:
				new_product.set_visibility(false)
		else:
			print("recipe not found")
		products.add_child(new_product)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func calculate_quantity(recipe: Recipe) -> int:
	#get recipe material's list
	#iterate through the list and divide the quantity required by how many is in 
	#player's inventory
	#we will return the lowest of the bunch as the number the player can make will be contingent on the lowest resource
	var material_inventory = Inventory.inventories["categories"]["materials"]
	var viable_amount = 99999999999
	
	if recipe.materials_list.size() == 0:
		return 0
	
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
