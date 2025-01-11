extends CanvasLayer

var show_hud : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	show_hud = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("hide_hud"):
		show_hud = !show_hud
	
	if show_hud:
		self.show()
	else:
		self.hide()
