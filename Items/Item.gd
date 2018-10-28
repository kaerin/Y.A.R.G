extends Node

onready var grid_map = get_parent()
onready var dic_weapon = get_parent().get_parent().get_node("Dictionaries/Items").weapons
onready var dic_chest = get_parent().get_parent().get_node("Dictionaries/Items").chest

var object = {}
var item
var name_
var texture
var rect

func _ready():
	#TODO random instancing of enemies in dictionary
#	$Label.text = object.base_name
	if is_network_master():
		$Label.text = item.get_name()
		self.texture = item.get_sprite_texture()
		set_region_rect(item.get_sprite_rect())
	else:
		$Label.text = name_
		self.texture = texture
		set_region_rect(rect)
	
	if G.debug:
		match item.BaseType:
			G.BaseType.Weap:
				print("Weapon drop")
			G.BaseType.Armour:
				print("Armour drop")
			G.BaseType.Wear:
				print("Wearable drop")
			_:
				print("Dropped something else")