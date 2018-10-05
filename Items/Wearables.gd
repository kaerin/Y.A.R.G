extends "res://Items/Inv.gd"

#Class to store all wepaon information
var BaseType = G.BaseType.Wear
var Type
var BonusAC = 0
var BonusDmg = 0

#set data
func set_type(i):
	Type = i

func set_bonus_ac(i):
	BonusAC = i

func set_bonus_dmg(i):
	BonusDmg = i
	
#get data
func get_type():
	return Type
	
func get_bonus_ac(): #weapon total damage
	return BonusAC

func get_ac_text(): #weapon total damage
	return str(BonusAC)


func get_bonus_dmg(): #weapon damage
	return BonusDmg
	
func get_dmg_text():
	if BonusDmg >= 0:
		return(str("+",BonusDmg))
	else:	
		return(str(BonusDmg))
	
func get_all_stats():
	return str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\nType: ", get_type(), "\nBonus AC: ", get_bonus_ac(), "\nBonus Dmg: ", get_bonus_dmg())
	