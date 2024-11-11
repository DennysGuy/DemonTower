extends Node
class_name HealthComponent

@export
var max_health: float

var cur_health: float
# Called when the node enters the scene tree for the first time.
func _ready():
	cur_health = max_health

func get_health() -> float:
	return cur_health

func set_heath(health : float):
	cur_health = health

func apply_damage(min_damage : int, max_damage : int):
	var applied_damage = randi_range(min_damage, max_damage)
	self.cur_health -= applied_damage
	if get_parent().name == "Player":
		GameManager.set_current_health(self.cur_health)

func apply_healing(health: float):
	if self.cur_health + health > self.max_health:
		self.cur_health = self.max_health
	else:
		self.cur_health += health
	if get_parent().name == "Player":
		GameManager.set_current_health(self.cur_health)
