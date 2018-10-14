extends "res://Items/Base.gd"

enum	RES	 {TYPE, VALUE}
#Class to store all wepaon information
var BaseType = G.BaseType.Wear
var Type
var BonusRes = 0
var BonusDmg = 0
var Res = []
var Dmg = []

#set data
func add_res(i,j):
	Res.append([i,j])
func add_dmg(i,j,k):
	Dmg.append([i,j,k])
	
func set_type(i):
	Type = i

func set_bonus_res(i):
	BonusRes = i

func set_bonus_dmg(i):
	BonusDmg = i
	
#get data
func get_type():
	return Type

func get_res():
	return Res
	
func get_bonus_res(): 
	return BonusRes

func get_res_specific(type):
	var j = 0
	for i in Res:
		if i[RES.TYPE] == type[RES.TYPE]:
			return i[RES.VALUE] + BonusRes
	return 0

#func get_ac_text(): #same as str(get_bonus_ac()) which makes more sense
#	return str(BonusRes)
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

func get_bonus_dmg(): #weapon damage
	return BonusDmg
	
func get_dmg_text(): #I'd put all the functions turning numbers into formatted string of text into visual, stats has all the numbers from everything
	var dmg_string = str(Dmg)
	if BonusDmg >= 0: #I'd keep these classes simple just have the data here, leave formatted text up to something else
		dmg_string += str("+",BonusDmg)
	else:	
		dmg_string += str(BonusDmg)
	return dmg_string

func get_res_text(): #I'd put all the functions turning numbers into formatted string of text into visual, stats has all the numbers from everything
	var res_string = str(Res)
	if BonusRes >= 0: #I'd keep these classes simple just have the data here, leave formatted text up to something else
		res_string += str("+",BonusRes)
	else:	
		res_string += str(BonusRes)
	return res_string
	

func get_all_stats():
	var data = str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\nType: ", get_type(), "\n")
	data += "Damage\n"
	for i in Dmg:
		data += str(i[0], " Dmg: ", i[1], "-", i[2],"\n")
	data += "Resistances\n"
	for i in Res:
		data += str(i[0],":",i[1],"\n")
	data += str("Bonus Res: ", get_bonus_res(), "\nBonus Dmg: ", get_bonus_dmg())
	return data
	