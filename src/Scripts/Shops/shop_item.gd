class_name ShopItem extends Control


const PLAYERSALEMODIFIER : int = 3

var item_data : Item
@onready var item_icon : TextureRect = $IconBG/ItemIcon
@onready var item_name : Label = $VBoxContainer/ItemName
@onready var item_price_tag : Label = $VBoxContainer/PriceTag
@export var quantity_label : Label

var belongs_to_player : bool

signal shop_action(item_data)
signal player_action(item_data)

# Called when the node enters the scene tree for the first time.
func _ready():
	if item_data:
		item_icon.texture = item_data.icon
		item_name.text = item_data.name
		if belongs_to_player:
			item_price_tag.text = "Sell: " + str(item_data.sell_value)
		else:
			item_price_tag.text = "Price: " + str(item_data.shop_value)

func _on_gui_input(event : InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if belongs_to_player:
			player_action.emit(item_data)
		else:
			shop_action.emit(item_data)

func set_item_data(item_data : Item):
	self.item_data = item_data
