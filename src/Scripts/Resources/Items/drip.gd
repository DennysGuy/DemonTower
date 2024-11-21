class_name Drip extends Item

enum DripClass {SHIRT, PANTS, SHOES}

@export_group("Drip Type")
@export_enum("Shirt", "Pants", "Shoes") var drip_type

@export_group("Visual Components")
@export var animation_name: String = ""

func get_drip_type_name() -> String:
	match(drip_type):
		DripClass.SHIRT:
			return "Shirt"
		DripClass.PANTS:
			return "Pants"
		DripClass.SHOES:
			return "Shoes"
		_:
			return ""
