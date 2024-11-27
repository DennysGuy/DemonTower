class_name Drip extends Item

enum DripClass {SHIRT, PANTS, SHOES}

@export_group("Drip Type")
@export_enum("Shirt", "Pants", "Shoes") var drip_type : int
@export_group("Visual Components")
@export var animation_name: String = ""

func get_drip_type_name() -> String:
	match(drip_type):
		DripClass.SHIRT:
			return "shirt"
		DripClass.PANTS:
			return "pants"
		DripClass.SHOES:
			return "shoes"
		_:
			return ""
