class_name Item extends Resource

enum TYPE {
	WEAPON,
	RECIPE,
	ACCESSORY,
	DRIP,
	CONSUMABLE,
	MATERIAL
}

@export var id : int
@export var name : String
@export_enum("Weapon", "Recipe", "Accessory", "Drip", "Consumable", "Material") var type : int
@export var description : String
@export var is_stackable : bool
@export var max_stack : int
@export var icon : Texture2D #needs to be 32x32

func get_item_inventory_name() -> String:
	match(type):
		TYPE.WEAPON:
			return "weapons"
		TYPE.RECIPE:
			return "recipes"
		TYPE.ACCESSORY:
			return "accessories"
		TYPE.DRIP:
			return "drip"
		TYPE.CONSUMABLE:
			return "consumables"
		TYPE.MATERIAL:
			return "materials"
		_:
			return ""
