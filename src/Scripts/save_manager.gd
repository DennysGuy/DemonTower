extends Node

var save_file_path : String = "user://save/"
var save_file_name : String = "PlayerSave.tres"

func load_player_data():
	return ResourceLoader.load(save_file_path + save_file_name).duplicate(true)

func save_player_data(player_data : Stats):
	DirAccess.make_dir_absolute(save_file_path)
	ResourceSaver.save(player_data, save_file_path + save_file_name)
