class_name Consumable extends Item
#consumables will not have a category and representations are more of an aesthetic
#consumables can replenish lost HP or MP or a temporary buff

enum ConsumableType {
	REPLENISHING,
	BUFF
}

@export_enum("Replenishing", "Buff") var consumable_type : int

@export_group("Replenishments")
@export var provided_hp : int
@export var provided_mp : int
@export_group("Buffs")
@export var buff_duration : int
@export var speed_buff_amount : float
@export var jump_buff_amount : float
@export var accuracy_buff_amount : float
@export var avoidability_buff_amount : float
@export var crit_rate_buff_amount : float
@export var crit_damage_buff_amount : float
@export var weapon_attack_buff_amount : float
@export var weapon_defense_buff_amount : float
@export var magic_attack_buff_amount : float
@export var magic_defense_buff_amount : float
@export var shadow_attack_buff_amount : float

func get_consumable_type_name() -> String:
	match(consumable_type):
		ConsumableType.REPLENISHING:
			return "Replenishing Consumable"
		ConsumableType.BUFF:
			return "Buff Consumable"
		_:
			return ""
