class_name NPCInteractable extends Area2D

@export var time_line : String
var player_in_range : bool
func _ready() -> void:
	player_in_range = false
	pass

func _process(delta: float) -> void:
	#print(player_in_range)
	if player_in_range and Input.is_action_just_pressed("move_up"):
		Dialogic.start(time_line)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false

		
