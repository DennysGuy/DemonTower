class_name ItemInteractable extends Node2D

@export var animation_player : AnimationPlayer
@export var item_data : Weapon
@export var quantity : int = 1
var can_be_picked_up : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	can_be_picked_up = false
	animation_player.play("Hover")

func _process(delta):
	if can_be_picked_up:
		if Input.is_action_just_pressed("pick_up_item"):		
			Inventory.add_item(item_data.get_item_inventory_name(), item_data, quantity)
			queue_free()

func _on_area_2d_body_entered(body):
	if body is Player:
		can_be_picked_up = true

func _on_area_2d_body_exited(body):
	if body is Player:
		can_be_picked_up = false
