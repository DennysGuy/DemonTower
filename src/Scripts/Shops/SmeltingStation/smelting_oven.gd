class_name SmeltingOven extends TextureButton

@export var product_crafting_station : ProductCraftingStation
# Called when the node enters the scene tree for the first time.
func _ready():
	product_crafting_station.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	print("i'm clicked!")
	if product_crafting_station.hidden:
		product_crafting_station.update_resource_list = true
		product_crafting_station.show()
