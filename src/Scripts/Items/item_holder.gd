class_name ItemHolder extends Node

#enemy holds a random set of items that can potentially be dropped
#enemy will always drop currency of some amount
@export_group("Items")
@export
var items : Array[Item]

@export_group("Currency Values")
@export
var min_currency_value : int
@export
var max_currency_value : int


# Function to spawn an item
func spawn_items():
	#need to figure out a way to set and implement a drop rate for certain items
	#some items will need to be more difficult to attain
	#some times enemy will drop multiple items
	#bosses will always drop a ton of items
	var item_drop = load("res://src/Scenes/Items/ItemInteractable.tscn").instantiate()
	if items.size() == 1:
		item_drop.item_data = items[0]
	else:
		var random_item : int = randi_range(0, items.size()-1)
		item_drop.item_data = items[random_item]
	item_drop.global_position = get_parent().global_position + Vector2(-15, -5)
	get_tree().current_scene.add_child(item_drop)

# Function to spawn currency
func spawn_currency():
	var coin_drop = load("res://src/Scenes/Items/CurrencyInteractable.tscn").instantiate()
	coin_drop.min_value = min_currency_value
	coin_drop.max_value = max_currency_value
	coin_drop.z_index = 999
	coin_drop.global_position = get_parent().global_position + Vector2(15, -5)
	get_tree().current_scene.add_child(coin_drop)
