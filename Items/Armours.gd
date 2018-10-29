extends "res://Items/Base.gd"

#Class to store all wepaon information
enum	RES	 {TYPE, VALUE}

var BaseType = G.BaseType.Armour
var Mat
var Location
var LocName
var BonusRes = 0
var Res = [] #resistance array of array like weapons
var ImgRect
var rpc_data = {}

func pack(): #pack and unpack the data within the class
	packBase()
	packedData['Res'] = Res
	
func unpack():
	unpackBase()
	Res = packedData['Res']

#set data
func add_res(i):
	Res.append([i[0],i[1]+G.Dlevel])
	
func set_mat(i):
	Mat = i
	
func set_location(i):
	Location = i
	
func set_loc_name(i):
	LocName = i

func set_bonus_res(i):
	BonusRes = i
	
#get data
func get_res_all():
	return Res

func get_res_specific(type):
	var j = 0
	for i in Res:
		if i[RES.TYPE] == type[RES.TYPE]:
			return i[RES.VALUE] + BonusRes
	return 0

func get_mat():
	return Mat

func get_location():
	return Location

func get_loc_name():
	return LocName
	
func get_bonus_res():
	return BonusRes

func get_all_stats():	
	var data = str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\nLocation Name: ", get_loc_name(), "\n")
	data += "Resistances\n"
	for i in Res:
		data += str(i[RES.TYPE],":",i[RES.VALUE],"\n")
	data += str("Bonus Res: ", BonusRes)
	return data
