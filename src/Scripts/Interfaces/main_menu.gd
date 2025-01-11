extends Control

@export
var sp_test_scene : PackedScene
@export
var multi_player_menu : PackedScene
@export
var player_hud : Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_single_player_start_button_down():
	get_tree().change_scene_to_file("res://src/Scenes/Interfaces/CharacterCreator.tscn")


func _on_multi_player_start_button_down():
	var multi_menu = load("res://src/Scenes/Interfaces/MultiplayerMenu.tscn").instantiate()
	get_tree().root.add_child(multi_menu)
	self.hide()


func _on_settings_button_down():
	pass # Replace with function body.


func _on_exit_button_down():
	get_tree().quit()
