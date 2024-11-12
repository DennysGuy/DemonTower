extends Area2D
class_name HitBox

@onready
var stats_component : StatsComponent = $"../StatsComponent"

@export
var knock_back_amount : float = 2.0
@export
var stun_time : int = 0

func _ready():
	var min_damage : int = stats_component.get_minimum_attack()
	var max_damage : int = stats_component.get_maximum_attack()
