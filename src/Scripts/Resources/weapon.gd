# weapon.gd
class_name Weapon extends Resource

# Relavent enums
enum ArchetypeClass { WARRIOR, MAGE, ROGUE }
enum WeaponClass { SWORDSHIELD, SPEAR, TWOHANDED, WAND, STAFF, KNIVES, CLAW }
enum WeaponSpeed {SLOWEST = 20, SLOW = 40, AVERAGE = 60, FAST = 80, VERYFAST = 100, Fastest = 150}
enum ElementalEffect {NORMAL, POISON, FIRE, ICE, LIGHTNING, WIND, SHADOW, HOLY}
enum XPType {STRENGTH, INTELLIGENCE, DEXLUCK}
# Exported variables for weapon attributes
@export_group("Weapon Meta Data")
@export var name: String = "New Weapon"
@export var description: String
@export var level: int
@export_enum("Warrior", "Mage", "Rogue") var archetype_class: int
@export_enum("Sword and Shield", "Spear", "Two-Handed", "Wand", "Staff", "Knives", "Claw") var weapon_class: int
@export_enum("Slowest:20", "Slow:40", "Average:60" , "Fast:80", "Very Fast:100", "Fastest:150") var weapon_speed: int
@export_enum("Common", "Uncommon", "Rare", "Very Rare", "Ultra Rare", "Legendary") var weapon_rarity: int
@export_enum("Normal", "Poison", "Fire", "Ice", "Lightning", "Wind", "Dark", "Light") var elemental_effect: int
@export_enum("Strength", "Intelligence", "Dex/Luck") var xp_type : int
var _archetype_name : String

@export_group("Weapon Stats")
@export var weapon_attack: int = 0
@export var weapon_defense: int = 0
@export var magic_attack: int = 0
@export var magic_defense: int = 0
@export var shadow_attack: int = 0
@export var shadow_defense: int = 0

@export_group("Weapon Bonuses")
@export var HP_bonus: int = 0
@export var MP_bonus: int = 0
@export var movement_speed_bonus: int = 0
@export var jump_bonus: int = 0

@export_group("Visual Components")
@export var animation_name: String = ""
@export var inventory_icon: Texture2D
@export var drop_icon: Texture2D
# Setter functions
func set_archetype_name(name : String) -> void:
	_archetype_name = name

# Getter functions
func get_weapon_name() -> String:
	return name

func get_archetype_name() -> String:
	return _archetype_name

func get_weapon_archetype_class() -> ArchetypeClass:
	return archetype_class

func get_weapon_class() -> WeaponClass:
	return weapon_class

func get_weapon_attack() -> int:
	return weapon_attack

func get_weapon_speed() -> int:
	return weapon_speed

func get_weapon_defense() -> int:
	return weapon_defense

func get_weapon_shadow_defense() -> int:
	return shadow_defense

func get_weapon_element() -> int:
	return elemental_effect

func get_weapon_rarity() -> int:
	return weapon_rarity

func get_weapon_magic_attack() -> int:
	return magic_attack

func get_weapon_magic_defense() -> int:
	return magic_defense

func get_weapon_HP_bonus() -> int:
	return HP_bonus

func get_weapon_MP_bonus() -> int:
	return MP_bonus

func get_movement_speed_bonus() -> int:
	return movement_speed_bonus

func get_jump_bonus() -> int:
	return jump_bonus

func get_archetype_class_name() -> String:
	match(archetype_class):
		ArchetypeClass.WARRIOR:
			return "Warrior"
		ArchetypeClass.MAGE:
			return "Mage"
		ArchetypeClass.ROGUE:
			return "Rogue"
		_:
			return "N/A"
