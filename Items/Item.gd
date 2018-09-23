extends Node

onready var grid_map = get_parent()
onready var dic_weapon = get_parent().get_parent().get_node("Dictionaries/Items").weapons
onready var dic_chest = get_parent().get_parent().get_node("Dictionaries/Items").chest

var object = {}

func _ready():
	#TODO random instancing of enemies in dictionary
		$Label.text = object.base_name