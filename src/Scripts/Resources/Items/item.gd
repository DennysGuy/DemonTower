class_name Item extends Resource

enum TYPE {
	WEAPON,
	RECIPE,
	ACCESSORY,
	DRIP,
	CONSUMABLE,
	WOOD,
	MATERIAL
}

enum RARITY {
	COMMON,
	UNCOMMON,
	RARE,
	VERY_RARE,
	ULTRA_RARE,
	LEGENDARY
}

@export var id : int
@export var name : String
@export var sell_value : int
@export var shop_value : int
@export var is_droppable : bool = true
@export_enum("Weapon", "Recipe", "Accessory", "Drip", "Consumable", "Wood", "Material") var type : int
@export_enum("Common", "Uncommon", "Rare", "Very Rare", "Ultra Rare", "Legendary") var rarity : int
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
		TYPE.WOOD:
			return "materials"
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
		TYPE.WOOD:
			return "wood"
		TYPE.MATERIAL:
			return "material"
		_:
			return ""

func get_rarity_name() -> String:
	match(rarity):
		RARITY.COMMON:
			return "Common"
		RARITY.UNCOMMON:
			return "Uncommon"
		RARITY.RARE:
			return "Rare"
		RARITY.VERY_RARE:
			return "Very Rare"
		RARITY.ULTRA_RARE:
			return "Ultra Rare"
		RARITY.LEGENDARY:
			return "Legendary"
		_:
			return ""
