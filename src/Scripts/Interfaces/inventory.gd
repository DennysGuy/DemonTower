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
		"gold": 1000,
		"key_ids": {  # For tracking auto-increment keys
			"weapons": 0,
			"recipes": 0,
			"accessories": 0,
			"drip": 0,
			"consumables": 0,
			"materials": 0
		}
	},
	"equipped_gear": {
		"weapon" : null,
		"hat": null,
		"gloves": null,
		"amulet": null,
		"shirt": null,
		"pants": null,
		"shoes": null
	}
}
# Helper function to add items
func add_item(category: String, item : Item, quantity: int = 1):
	var inventory = inventories["categories"][category]
	var item_key = search_item(inventory, item.id)
	
	if item.is_stackable and item_key != -1:
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
	print("category: ", category)
	print(inventory)
		
func remove_item(category: String, item : Item, quantity : int = 1) -> Array:
	var inventory = inventories["categories"][category]
	var item_key = search_item(inventory, item.id)
	var slot = inventory[item_key]
	var true_quantity = quantity
	var item_drop : Item = inventory[item_key]["item"]
	if item_key != null:
		if item_drop.is_stackable:
			var difference = max(0, slot["quantity"]-quantity)
			if difference == 0:
				true_quantity = slot["quantity"]
				inventory.erase(item_key)
			else:
				slot["quantity"] -= quantity
		else:
			inventory.erase(item_key)
		
		if item_drop.is_droppable:
			if item_drop.is_stackable:
				return [item_drop, true_quantity]
			else:
				return [item_drop, 1]
		else:
			#we'll need to prompt the user that if they decide to drop, that it will be permanently discarded
			return []
	else:
		print_debug("Item not found in inventory!")
		return []
# Helper function to search for an item by ID
func search_item(inventory: Dictionary, item_id: int) -> int:
	for key in inventory.keys():
		if inventory[key]["id"] == item_id:
			return key
	return -1

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

func equip_gear(category: String, gear):
	inventories["equipped_gear"][category] = gear

func un_equip_gear(category: String):
	inventories["equipped_gear"][category] = null
