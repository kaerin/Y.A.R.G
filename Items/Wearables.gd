extends Reference

#Class to store all wepaon information

var Name
var Type
var BonusAC
var BonusDmg

#set data
func set_name(i):
	Name = i

func set_type(i):
	Type = i

func set_bonus_ac(i):
	BonusAC = i

func set_bonus_dmg(i):
	BonusDmg = i

#get data
func get_name():
	return Name

func get_type():
	return Type
	
func get_bonus_ac(): #weapon total damage
	return BonusAC

func get_bonus_dmg(): #weapon damage
	return BonusDmg