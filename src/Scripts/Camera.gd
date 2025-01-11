extends Camera2D

@export_category("Follow Character")
@export var player : Player
@export_category("Camera smoothing")
@export var smoothing_enabled : bool
@export_range(1,10) var smoothing_distance : int = 8

var weight : float
var room_bounds: Rect2 = Rect2(Vector2.ZERO, Vector2(1800, 270))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weight = float(11 - smoothing_distance)/100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if player != null:
		var camera_position : Vector2
		
		if smoothing_enabled:
			camera_position = lerp(global_position, player.global_position, weight)
		else:
			camera_position = player.global_position
		var clamped_position = camera_position.clamp(room_bounds.position, room_bounds.position + room_bounds.size)
		global_position = clamped_position.floor()
