extends Reference

#Class to store all wepaon information

var Name
var BaseType
var ArmourClass
var BonusAC

#set data
func set_name(i):
	Name = i

func set_base_type(i):
	BaseType = i

func set_ac(i):
	ArmourClass = i

func set_bonus_ac(i):
	BonusAC = i

#get data
func get_name():
	return Name

func get_base_type():
	return BaseType
	
func get_ac(): #weapon total damage
	return get_armour_ac() + BonusAC

func get_armour_ac(): #weapon damage
	return ArmourClass