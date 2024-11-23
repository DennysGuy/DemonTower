class_name Accessory extends Item

# accessories have 3 types :
# hat, gloves, amulet
# hats and gloves are drawn over the player, but amulet isn't
# accessories are items that give stat bonuses
# accessories can provide defense, avoidability
# number of upgrades
enum AccessoryType {HAT, GLOVES, AMULET}
@export_enum("Hat", "Gloves", "Amulet") var accessory_type : int
@export_group("Item Level")
@export var level : int
@export_group("Stats Buffs")
@export var crit_damage_bonus : int
@export var crit_rate_bonus : int
@export var speed_bonus : int
@export var jump_bonus : int
@export var avoidability_bonus : int
@export var accuracy_bonus : int
@export var hp_bonus : int
@export var mp_bonus : int
@export var weapon_defense_bonus : int
@export var magic_defense_bonus : int

func get_accessory_type() -> String:
	match(accessory_type):
		AccessoryType.HAT:
			return "hat"
		AccessoryType.GLOVES:
			return "gloves"
		AccessoryType.AMULET:
			return "amulet"
		_:
			return ""
