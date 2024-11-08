extends Node

var players = {}
var selected_player = {
	"name": "",
	"color": ""
}
var selected_color : String = selected_player["color"]
var character_name : String = selected_player["name"]
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
