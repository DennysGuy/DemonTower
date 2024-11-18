extends Control


@export var item: Item
@export var show_quantity : bool
@onready var slot_icon : TextureRect = $SlotIcon
@onready var quantity_label : Label = $Quantity

var quantity : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item:
		slot_icon.texture = item.icon
		#need to set quantity label
		
	if item.stackable:
		show_quantity = true
	else:
		show_quantity = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if show_quantity:
		quantity_label.show()
	else:
		quantity_label.hide()
