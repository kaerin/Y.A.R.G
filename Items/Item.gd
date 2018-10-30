extends Node

onready var grid_map = get_parent().get_parent()
onready var dic_weapon = get_node("../../../Dictionaries/Items").weapons
onready var dic_chest = get_node("../../../Dictionaries/Items").chest

var Weapons = load("res://Items/Weapons.gd")

var object = {}
var item			#<---- this wont pass properlly through RPC, making the existing concept difficult for multiplayer.
var name_
var texture
var rect
var rpc_data = {}
var packedData

func _ready():
	#TODO random instancing of enemies in dictionary
#	$Label.text = object.base_name
	if is_network_master():
		$Label.text = item.get_name()
		self.texture = item.get_sprite_texture()
		set_region_rect(item.get_sprite_rect())
	else: #Else call the unpack data function within the class itself instead of coding each type here
		if rpc_data.has('Type'):
			if rpc_data.Type == 'Weapon':
				var a = Weapons.new()
				a.Name = rpc_data.Name
				a.Dmg = rpc_data.Dmg
				a.BonusDamage = rpc_data.BonusDamage
				a.sprite_rect = rpc_data.Rect
				item = a
				$Label.text = item.get_name()
				self.texture = item.get_sprite_texture()
				set_region_rect(item.get_sprite_rect())				
				print('rpc data for item : ' + str(rpc_data))
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