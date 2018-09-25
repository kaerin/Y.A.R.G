extends Reference

#Class to store all wepaon information

var Name
var DmgType
var MinDamage = 1
var MaxDamage = 1
var BonusDamage = 0


#set data
func set_name(i):
	Name = i

func set_dmg_type(i):
	DmgType = i

func set_damage(i,j):
	MinDamage = i
	MaxDamage = j

func set_bonus_dmg(i):
	BonusDamage = i

#get data
func get_name():
	return Name

func get_dmg_type():
	return DmgType
	
func get_damage(): #weapon total damage
	return get_weapon_damage() + BonusDamage

func get_weapon_damage(): #weapon damage
	return randi() % (MaxDamage - MinDamage) + MinDamage
	
func get_bonus_damage(): #weapon total damage
	return BonusDamage