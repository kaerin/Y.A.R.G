extends Node

onready var grid_map = get_parent()
onready var dic_weapon = get_parent().get_parent().get_node("Dictionaries/Items").weapons
onready var dic_chest = get_parent().get_parent().get_node("Dictionaries/Items").chest

var object = {}
var item

func _ready():
	#TODO random instancing of enemies in dictionary
#	$Label.text = object.base_name
	$Label.text = item.get_name()
	match item.BaseType:
		G.BaseType.Weap:
			print("Weapon drop")
			set_region_rect(Rect2(992,1536,32,32))
		G.BaseType.Armour:
			set_region_rect(Rect2(1472,1184,32,32))
			print("Armour drop")
		G.BaseType.Wear:
			print("Wearable drop")
			set_region_rect(Rect2(32,1120,32,32))
		_:
			print("Dropped something else")