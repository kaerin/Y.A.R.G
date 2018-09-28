extends Reference

#Class to store all wepaon information

var BaseType = G.BaseType.Wear
var Name
var is_equipped
var Type
var BonusAC = 0
var BonusDmg = 0

#set data
func set_equipped():
	is_equipped = true

func set_not_equipped():
	is_equipped = false
	
func set_name(i):
	Name = i

func set_type(i):
	Type = i

func set_bonus_ac(i):
	BonusAC = i

func set_bonus_dmg(i):
	BonusDmg = i

#get data
func get_equipped():
	return is_equipped
	
func get_name():
	return Name

func get_type():
	return Type
	
func get_bonus_ac(): #weapon total damage
	return BonusAC

func get_bonus_dmg(): #weapon damage
	return BonusDmg