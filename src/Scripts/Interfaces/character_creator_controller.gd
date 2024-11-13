extends Control

@onready
var preview_animations : AnimatedSprite2D = $PlayerCharacterPreview/PreviewAnimations
@onready
var name_box : LineEdit = $LineEdit
@onready
var character : Label = $Character
var index : int = 0
var selected_color = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match index:
		0:
			preview_animations.play("BlueCharacterPreview")
			selected_color = "Blue"
			character.text = "Blue Guy"
		1:
			preview_animations.play("GreenCharacterPreview")
			selected_color = "Green"
			character.text = "Green Guy"
		2:
			preview_animations.play("RedCharacterPreview")
			selected_color = "Red"
			character.text = "Red Guy"

func _on_cycle_right_button_button_down():
	index += 1
	if index > 2:
		index = 0


func _on_cycle_left_button_button_down():
	index -= 1
	if index < 0:
		index = 2


func _on_start_game_button_down():
	GameManager.set_player_name(name_box.text)
	
	#print_debug("the players name is: " + GameManager.selected_player["name"])
	GameManager.set_player_color(selected_color)
	
	#print_debug("the players color is: " + GameManager.selected_player["color"])
	get_tree().change_scene_to_file("res://src/Scenes/Rooms/TestLevel.tscn")
