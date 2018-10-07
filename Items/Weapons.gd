extends "res://Items/Base.gd"

#Class to store all wepaon information
var BaseType = G.BaseType.Weap
var DmgType
var MinDamage = 1
var MaxDamage = 1
var BonusDamage = 0


#set data
func set_dmg_type(i):
	DmgType = i

func set_damage(i,j):
	MinDamage = i
	MaxDamage = j

func set_bonus_dmg(i):
	BonusDamage = i

#get data
func get_dmg_type():
	return DmgType	
	
func get_damage(): #weapon total damage
	return get_weapon_damage() + BonusDamage

func get_weapon_damage(): #weapon damage
	return randi() % (MaxDamage - MinDamage) + MinDamage
	
func get_bonus_dmg(): #weapon total damage
	return BonusDamage
	
func get_min_dmg():
	return MinDamage
	
func get_max_dmg():
	return MaxDamage
	
func get_dmg_text():
	var dmg_string = str(MinDamage,"-",MaxDamage)
	if BonusDamage > 0:
		dmg_string += str("+",BonusDamage)
	elif BonusDamage < 0:	
		dmg_string += str(BonusDamage)
	return(dmg_string)
	
func get_all_stats():
	return str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\nDmg Type: ", get_dmg_type(), "\nMin Dmg: ", get_min_dmg(), "\nMax Dmg: ", get_max_dmg(), "\nBonus Dmg: ", get_bonus_dmg())
