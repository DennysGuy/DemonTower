extends Entity

@export
var jump_force := 300

var has_jumped := false

var in_ladder_area := false

@onready
var camera := $Camera2D
@onready
var multiplayer_synchronizer := $MultiplayerSynchronizer
var sync_position := Vector2(0,0)
# Called when the node enters the scene tee for the first time.
func _ready() -> void:
	multiplayer_synchronizer.set_multiplayer_authority(str(name).to_int())
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		camera.make_current()
	else:
		camera.enabled = false
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		state_machine.process_frame(delta)

func _on_area_2d_body_entered(body):
	self.in_ladder_area = true

func _on_area_2d_body_exited(body):
	self.in_ladder_area = false
