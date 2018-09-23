extends Node

onready var grid_map = get_parent()
onready var dic_items = get_parent().get_parent().get_node("Dictionaries/Items").items

var items = {}

func _ready():
	#TODO random instancing of enemies in dictionary
	var rnd_item = randi() % (dic_items.size() - 1)
	items = dic_items[rnd_item + 1]
	$Label.text = items.base_name
