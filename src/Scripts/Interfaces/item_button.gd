class_name InventorySlot extends Control


@export var item_data: Item
@export var show_quantity : bool
@export var slot_icon : TextureRect
@export var quantity_label : Label

var description : String

var quantity : int

signal slot_action(item_data)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item_data:
		set_item_icon(item_data)
		set_item_description(item_data.description)
		#need to set quantity label
		if show_quantity:
			quantity_label.show()
		else:
			quantity_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_item_data(item_data):
		self.item_data = item_data

func set_quantity_label(value : int):
		if quantity_label:
			quantity_label.text = str(value)
		else:
			print_debug("quantity label ain't here fam.")

func set_item_icon(item_data):
	slot_icon.texture = item_data.icon

func set_item_description(description: String):
	self.description = description

func _on_gui_input(event : InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print_debug("I'm clicked!!")
		slot_action.emit(item_data)
