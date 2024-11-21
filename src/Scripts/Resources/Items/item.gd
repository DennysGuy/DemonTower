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
@export var value : int
@export_enum("Weapon", "Recipe", "Accessory", "Drip", "Consumable", "Material") var type : int
@export var description : String
@export var is_stackable : bool
@export var max_stack : int
@export var icon : Texture2D #needs to be 16x16

func generate_unique_id() -> void:
	var uuID = ResourceUID.create_id()
	id = uuID


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

func get_item_category() -> String:
	match(type):
		TYPE.WEAPON:
			return "weapon"
		TYPE.RECIPE:
			return "recipe"
		TYPE.ACCESSORY:
			return "accessory"
		TYPE.DRIP:
			return "drip"
		TYPE.CONSUMABLE:
			return "consumable"
		TYPE.MATERIAL:
			return "material"
		_:
			return ""
