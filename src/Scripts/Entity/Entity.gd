class_name Entity
extends CharacterBody2D

@onready
var animation_player = $animations
@onready
var state_machine = $StateMachine
var was_hit : bool = false
var can_attack = false
var enemy_hitbox_parent : Entity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export
var enable_gravity : bool = true
# Called when the node enters the scene tee for the first time.
func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	if enable_gravity:
		GameManager.apply_gravity(self, gravity, delta)
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
