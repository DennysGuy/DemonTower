class_name stats_calculator extends Node

#level
var level : int
#core stats
var strength : int 
@export var dexterity : int
@export var intelligence : int
@export var luck : int
#secondary stats
@export var attack_power : int
@export var weapon_defnse : int
@export var magic_attack : int
@export var magic_defense : int 
@export var critical_rate : int
@export var critical_damage : int
@export var defense : int
@export var accuracy : int
@export var avoidability : int
#movement stuff
@export var speed : int
@export var jump : int
#progression rates
@export var drop_rate : int
@export var xp_rate : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
