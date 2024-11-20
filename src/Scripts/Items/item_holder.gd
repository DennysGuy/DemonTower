class_name ItemHolder extends Node

#enemy holds a random set of items that can potentially be dropped
#enemy will always drop currency of some amount
@export_group("Items")
@export
var items : Array[Item]

@export_group("Currency Values")
@export
var min_currency_value : int
@export
var max_currency_value : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
