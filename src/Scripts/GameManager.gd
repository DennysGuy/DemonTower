extends Node

var players = {}
var selected_player = {
	"name": "",
	"color": "",
	"max_health": 25.0, #for setting initial health
	"current_health": 25.0 #keeping track of current health
}
var selected_color : String = selected_player["color"]
var character_name : String = selected_player["name"]
var player_health : float = selected_player["max_health"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_direction(dir_vector : float):
	if (dir_vector < 0):
		return -1
	else:
		return 1
func set_player_hitbox_direction(dir_vector : float):
	if (dir_vector == 0):
		return 1
	else:
		return -1
func apply_gravity(entity : Entity, gravity, delta):
	entity.velocity.y += gravity * delta
