class_name Recipe extends Item

#need to plan this out.
#A Recipe is a list of materials needed to craft a given item
#Recipes are necessary for crafting the majority of weapons and accessories
#Drip does not need to be crafted as it will be bought from various locations and possibly monster drops as they do not provide any sort of stat ehancements
#Recipes will be consumed or 'unlocked', once the player has unlocked a recipe, the player will be able to craft that given piece of gear at a crafting station
#A Recipe will have a name, description, and type either weapon or accessory. 
#A Recipe will also have a list of crafting materials and quantities for each
#Need to figure out chain of events when a recipe is unlocked
enum RecipeType {
	RESOURCE,
	WEAPON,
	ACCESSORY,
	DISH
}
@export var recipe_level: int #this will be compared to player's level. If greater than player's level, player will not be able to craft item
@export var crafting_fee: int
@export var crafting_time_cost: int
@export var xp_provided : int
@export_enum("Resource","Weapon", "Accessory", "Dish") var recipe_type : int
@export var output_item : Item
@export var materials_list : Dictionary
var player_can_craft : bool
func get_recipe_type_name() -> String:
	match(recipe_type):
		RecipeType.RESOURCE:
			return "Resource"
		RecipeType.WEAPON:
			return "Weapon"
		RecipeType.ACCESSORY:
			return "Accessory"
		RecipeType.DISH:
			return "Dish"
		_:
			return ""
			
func get_recipe() -> String:
	var recipe_text : String
	
	for material in materials_list:
		recipe_text += material.name + " x " + str(materials_list[material]) + "\n"
	
	return recipe_text
