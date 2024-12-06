extends TextureButton

@onready var equip_crafting_station = $EquipmentCraftingStation
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	equip_crafting_station.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	if equip_crafting_station.hidden:
		equip_crafting_station.update_inventory_panel = true
		equip_crafting_station.update_craft_panel = true
		equip_crafting_station.update_details_panel = true
		equip_crafting_station.show()
