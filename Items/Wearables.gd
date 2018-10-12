extends "res://Items/Base.gd"

#Class to store all wepaon information
var BaseType = G.BaseType.Wear
var Type
var BonusAC = 0
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

func set_bonus_ac(i):
	BonusAC = i

func set_bonus_dmg(i):
	BonusDmg = i
	
#get data
func get_type():
	return Type
	
func get_bonus_ac(): 
	return BonusAC

func get_ac_text(): #same as str(get_bonus_ac()) which makes more sense
	return str(BonusAC)


func get_bonus_dmg(): #weapon damage
	return BonusDmg
	
func get_dmg_text(): #I'd put all the functions turning numbers into formatted string of text into visual, stats has all the numbers from everything
	if BonusDmg >= 0: #I'd keep these classes simple just have the data here, leave formatted text up to something else
		return(str("+",BonusDmg))
	else:	
		return(str(BonusDmg))
	
func get_all_stats():
	var data = str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\nType: ", get_type(), "\n")
	data += "Damage\n"
	for i in Dmg:
		data += str("Type: ", i[0], " Dmg: ", i[1], "-", i[2],"\n")
	data += "Resistances\n"
	for i in Res:
		data += str(i[0],":",i[1],"\n")
	data += str("Bonus AC: ", get_bonus_ac(), "\nBonus Dmg: ", get_bonus_dmg())
	return data
	