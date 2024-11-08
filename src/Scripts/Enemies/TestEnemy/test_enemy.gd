extends Entity

var player_seen = false
var can_attack = false
var player

@onready
var timer : Timer = $Timer

func _on_player_detector_body_entered(body : CharacterBody2D):
	if body.name == "Player":
		timer.wait_time = 5
		player = body
		player_seen = true


func _on_attack_range_body_entered(body : CharacterBody2D):
	if body.name == "Player":
		print_debug("I can attack!")
		can_attack = true


func _on_attack_range_body_exited(body : CharacterBody2D):
	if body.name == "Player":
		print_debug("I can't attack!")
		can_attack = false


func _on_player_detector_body_exited(body):
	if body.name =="Player":
		timer.start()
		player_seen = false
