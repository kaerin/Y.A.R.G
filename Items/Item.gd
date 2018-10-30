extends Node

onready var grid_map = get_parent().get_parent()
onready var dic_weapon = get_node("../../../Dictionaries/Items").weapons
onready var dic_chest = get_node("../../../Dictionaries/Items").chest

var Weapons = load("res://Items/Weapons.gd")
var Armours = load("res://Items/Armours.gd")
var Wearables = load("res://Items/Wearables.gd")

var object = {}
var item			#<---- this wont pass properlly through RPC, making the existing concept difficult for multiplayer.
#var name_
#var texture
#var rect
#var rpc_data = {}
var PackedData 

func _ready():
	#TODO random instancing of enemies in dictionary
#	$Label.text = object.base_name
	if PackedData.has('BaseType'):
		if PackedData.BaseType == 'Weapon':
			item = Weapons.new()
		elif PackedData.BaseType == 'Armour':
			item = Armours.new()
		elif PackedData.BaseType == 'Wearable':
			item = Wearables.new()

		item.PackedData = PackedData
		item.unpack()
		$Label.text = item.get_name()
		self.texture = item.get_sprite_texture()
		set_region_rect(item.get_sprite_rect())

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