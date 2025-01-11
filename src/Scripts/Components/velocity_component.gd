extends Node
class_name VelocityComponent

@export
var move_speed : float
@export
var jump_strength : float
@export
var entity : Entity

func apply_horizontal_movement(dir : int, entity : Entity):
	entity.velocity.x = dir * move_speed
	entity.set_floor_snap_length(30)
	entity.apply_floor_snap()

func apply_vertical_movement():
	self.entity.velocity.y = -jump_strength
	
func set_move_speed(move_speed : float):
	self.move_speed = move_speed
	
func set_jump_strength(jump_strength : float):
	self.jump_strength = jump_strength
