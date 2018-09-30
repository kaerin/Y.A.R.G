extends Reference

#Class to store all wepaon information

var texture = load("res://Data/ProjectUtumno_full.png")
var sprite_rect = Rect2(992,1536,32,32)

var BaseType = G.BaseType.Weap
var Name
var is_equipped
var DmgType
var MinDamage = 1
var MaxDamage = 1
var BonusDamage = 0


#set data
func set_equipped():
	is_equipped = true

func set_not_equipped():
	is_equipped = false

func set_name(i):
	Name = i

func set_dmg_type(i):
	DmgType = i

func set_damage(i,j):
	MinDamage = i
	MaxDamage = j

func set_bonus_dmg(i):
	BonusDamage = i
	
func set_unequip():
	is_equipped = false	

#get data
func get_equipped():
	return is_equipped

func get_name():
	return Name
	
func get_sprite_texture():
	return texture

func get_sprite_rect():
	return sprite_rect

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
	
func get_all_stats():
	return str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\nDmg Type: ", get_dmg_type(), "\nMin Dmg: ", get_min_dmg(), "\nMax Dmg: ", get_max_dmg(), "\nBonus Dmg: ", get_bonus_dmg())
