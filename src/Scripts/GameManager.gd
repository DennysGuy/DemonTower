extends Node

var players = {}

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
