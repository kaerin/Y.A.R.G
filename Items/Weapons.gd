extends Reference

#Class to store all wepaon information

var Name
var Type
var MinDamage
var MaxDamage #etc
var BonusDamage = 0


#set data
func set_name(i):
	Name = i

func set_type(i):
	Type = i

func set_damage(i,j):
	MinDamage = i
	MaxDamage = j

func set_bonus_dmg(i):
	BonusDamage = i

#get data
func get_name():
	return Name

func get_type():
	return Type
	
func get_damage(): #weapon total damage
	return get_weapon_damage() + BonusDamage

func get_weapon_damage(): #weapon damage
	return randi() % (MaxDamage - MinDamage) + MinDamage