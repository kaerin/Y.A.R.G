extends "res://Items/Base.gd"

#Class to store all wepaon information
var BaseType = G.BaseType.Weap
var Dmg = [] #Dmg is now an array or arrays, Type, min dmg, max dmg. See items a regular attack and a fire attack
var BonusDamage = 0
#var rpc_data = {}

func pack():
	packBase()
	PackedData['Dmg'] = Dmg
	PackedData['BonusDamage'] = BonusDamage
	PackedData['BaseType'] = BaseType
	
func unpack():
	unpackBase()
	Dmg = PackedData['Dmg']
	BaseType = PackedData['BaseType']
	BonusDamage = PackedData['BonusDamage']
	
#func gen_rpc_data():
#	rpc_data = {'Type' : BaseType, 'Dmg' : Dmg, 'BonusDamage' : BonusDamage, 'Name' : Name, 'Rect' : sprite_rect}

#set data
func add_dmg(i):
	Dmg.append([i[0],i[1]+G.Dlevel,i[2]+G.Dlevel])
	
func set_bonus_dmg(i):
	BonusDamage = i

#get data
func get_dmg_type(i=0):
	return Dmg[i][0]	
	
func get_dmg(): #weapon total damage
	var j = []
	for i in Dmg.size():
		j.append([get_dmg_type(i), get_weapon_dmg(i) + get_bonus_dmg()])
	return j #dmg aray create of type and damage

func get_weapon_dmg(i=0): #weapon damage
	return randi() % (get_max_dmg(i) - get_min_dmg(i)) + get_min_dmg(i)
	
func get_bonus_dmg(): #weapon total damage
	return BonusDamage
	
func get_min_dmg(i=0):
	if i < 0:
		var j = 0
		for k in Dmg:
			j += k[1]
		return j
	else:
		return Dmg[i][1]
	
func get_max_dmg(i=0):
	if i < 0:
		var j = 0
		for k in Dmg:
			j += k[2]
		return j
	else:
		return Dmg[i][2]

func get_dmg_all():
	return Dmg

func get_all_stats():
	var data = str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\n")
	data += "Damage\n"
	for i in Dmg:
		data += str("Type: ", i[0], " Dmg: ", i[1], "-", i[2],"\n")
	data += str("Bonus Dmg: ", get_bonus_dmg())
	return data
