extends Reference

#Class to store all wepaon information

var Name
var Location
var LocName
var ArmourClass
var BonusAC

#set data
func set_name(i):
	Name = i

func set_location(i):
	Location = i
	
func set_loc_name(i):
	LocName = i

func set_ac(i):
	ArmourClass = i

func set_bonus_ac(i):
	BonusAC = i

#get data
func get_name():
	return Name

func get_location():
	return Location

func get_loc_name():
	return LocName
	
func get_ac(): #weapon total damage
	return get_armour_ac() + BonusAC

func get_armour_ac(): #weapon damage
	return ArmourClass