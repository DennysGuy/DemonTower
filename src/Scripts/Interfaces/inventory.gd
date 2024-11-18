extends Node

var inventories : Dictionary = {
	"weapons" : {},
	"recipes" : {},
	"accessories" : {},
	"drip" : {},
	"consumables" : {},
	"materials" : {},
	"slot_quantity" : 25,
	"gold" : 125
}

# Helper function to add items
func add_item(category : String, item : Item, quantity : int = 1):
	var inventory = inventories[category]
	var item_key = search_item(inventory, item.id)
	
	if item_key:
		# Stackable items (like consumables)
		inventory[item_key]["quantity"] += quantity
	else:
		if inventory[category].keys() < inventory["slot_quantity"]:
			# Non-stackable items (like weapons or recipes)
			inventory[category + "_key_id"] += 1
			inventory[category + "_key_id"] = {
				"id": item.id,
				"name": item.name,
				"quantity": quantity
			}
		else:
			print_debug("Inventory tab is full!")

# Helper function to remove items
func remove_item(category : String, item : Item):
	var inventory = inventories[category]
	var item_key = search_item(inventory, item.id)
	if item_key:
		inventory.erase(item_key)
		inventory[category + "_key_id"] -= 1

# Helper function for searching an item
func search_item(inventory : Dictionary, item_id : int):
	for key in inventory.keys():
		var item = inventory[key]
		if item["id"] == item_id:
			return key
	return null

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
