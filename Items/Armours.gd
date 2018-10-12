extends "res://Items/Base.gd"

#Class to store all wepaon information
enum	RES	 {TYPE, VALUE}

var BaseType = G.BaseType.Armour
var Mat
var Location
var LocName
var ArmourClass = 0
var BonusAC = 0
var Res = [] #resistance array of array like weapons
var ImgRect

#set data
func add_res(i):
	Res.append([i[0],i[1]+G.Dlevel])
	
func set_mat(i):
	Mat = i
	
func set_location(i):
	Location = i
	
func set_loc_name(i):
	LocName = i

func set_ac(i):
	ArmourClass = i

func set_bonus_ac(i):
	BonusAC = i
	
#get data
func get_res():
	return Res

func get_res_specific(type):
	var j = 0
	for i in Res:
		if i[RES.TYPE] == type[RES.TYPE]:
			return i[RES.VALUE] + BonusAC
	return 0

func get_mat():
	return Mat

func get_location():
	return Location

func get_loc_name():
	return LocName
	
func get_ac(): 
	return get_armour_ac() + get_bonus_ac()

func get_ac_text(): #same as set(get_ac())
	return str(get_armour_ac() + get_bonus_ac())

func get_armour_ac(): 
	return ArmourClass

func get_bonus_ac():
	return BonusAC

func get_all_stats():	
	var data = str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\nLocation Name: ", get_loc_name(), "\n")
	data += "Resistances\n"
	for i in Res:
		data += str(i[RES.TYPE],":",i[RES.VALUE],"\n")
	data += str("Bonus Res: ", BonusAC)
	return data
