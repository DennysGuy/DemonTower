class_name Item extends Resource

enum TYPE {
	WEAPON,
	RECIPE,
	ACCESSORY,
	DRIP,
	MATERIAL
}

@export var id : int
@export var name : String
@export_enum("Weapon", "Recipe", "Accessory", "Drip", "Material") var type : int
@export var description : String
@export var is_stackable : bool
@export var max_stack : int
@export var icon : Texture2D #needs to be 32x32

		
