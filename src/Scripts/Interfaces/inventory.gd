extends Node

var inventories : Dictionary = {
	"categories": {
		"weapons": {},
		"recipes": {},
		"accessories": {},
		"drip": {},
		"consumables": {},
		"materials": {}
	},
	"metadata": {
		"slot_quantity": 25,
		"gold": 125,
		"key_ids": {  # For tracking auto-increment keys
			"weapons": 0,
			"recipes": 0,
			"accessories": 0,
			"drip": 0,
			"consumables": 0,
			"materials": 0
		}
	}
}

# Helper function to add items
func add_item(category: String, item: Item, quantity: int = 1):
	var inventory = inventories["categories"][category]
	var item_key = search_item(inventory, item.id)
	
	if item_key:
		# Stackable items (like consumables)
		inventory[item_key]["quantity"] += quantity
	else:
		# Check if inventory is full
		if inventory.keys().size() < inventories["metadata"]["slot_quantity"]:
			# Add a new item
			var next_key = inventories["metadata"]["key_ids"][category]
			inventory[next_key] = {
				"id": item.id,
				"name": item.name,
				"quantity": quantity,
				"item": item
			}
			# Increment key_id for this category
			inventories["metadata"]["key_ids"][category] += 1
		else:
			print_debug("Inventory tab is full!")

func remove_item(category: String, item: Item):
	var inventory = inventories["categories"][category]
	var item_key = search_item(inventory, item.id)
	if item_key != null:
		inventory.erase(item_key)
	else:
		print_debug("Item not found in inventory!")

# Helper function to search for an item by ID
func search_item(inventory: Dictionary, item_id: int) -> int:
	for key in inventory.keys():
		if inventory[key]["id"] == item_id:
			return key
	return 0

func add_gold(value : int):
	inventories["gold"] += value

func remove_gold(value :int):
	if inventories["gold"] > 0:
		inventories["gold"] -= value
	else:
		print_debug("You have no gold to drop!")
		return
	
	if inventories["gold"] < 0:
		inventories["gold"] = 0
