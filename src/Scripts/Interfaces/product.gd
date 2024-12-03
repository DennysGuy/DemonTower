class_name Product extends Control

@export var recipe : Recipe
@export var unlocked_recipe : ColorRect
@export var locked_recipe : ColorRect
@export var recipe_name : Label
@export var quantity : Label
@export var cost : Label

var show : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if show:
		unlocked_recipe.show()
		locked_recipe.hide()
		recipe_name.text = recipe.recipe_name
		cost.text = "Cost: " + str(recipe.crafting_fee)
		#I need to figure out a way to calculate the resources in player inventory and  
	else:
		unlocked_recipe.hide()
		locked_recipe.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_visibility(visible : bool):
	show = visible

func set_recipe(recipe : Recipe) -> void:
	recipe = load(recipe.resource_path)
