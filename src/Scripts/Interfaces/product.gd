class_name Product extends Control

@export var recipe : Recipe
@export var unlocked_recipe : ColorRect
@export var locked_recipe : ColorRect
@export var recip_icon : TextureRect
@export var recipe_name : Label
@export var quantity : Label
@export var cost : Label

signal select_recipe(recipe)
var show : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if show:
		unlocked_recipe.show()
		locked_recipe.hide()
		recip_icon.texture = recipe.icon
		recipe_name.text = recipe.name
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

func _on_gui_input(event : InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("I'm clicked!!")
		select_recipe.emit(recipe)
