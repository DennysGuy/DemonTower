extends Area2D
class_name HitBox

@onready
var stats_component : StatsComponent = $"../StatsComponent"

@export
var knock_back_amount : float = 2.0
@export
var stun_time : int = 0
