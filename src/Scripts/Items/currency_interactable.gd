class_name CurrencyInteractable extends Node2D

@onready var icon : Sprite2D = $Sprite2D
@export_group("Currency Value")

@export
var min_value : int = 1
@export
var max_value : int = 5
var _value : int
var can_pick_up : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	_value = randi_range(min_value, max_value)
	can_pick_up = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_pick_up:
		if Input.is_action_just_pressed("pick_up_item"):
			Inventory.inventories["metadata"]["gold"] += _value
			queue_free()

func _on_area_2d_body_entered(body):
	if body is Player:
		can_pick_up = true



func _on_area_2d_body_exited(body):
	if body is Player:
		can_pick_up = false
